const express = require('express');
const cors = require('cors')
const mysql = require('mysql')
const {v4:uuidv4} = require('uuid')

const HTTP_PORT = 8000

const conDibbs = mysql.createPool({
    host:"localhost",
    user:"root",
    password:"p21aA£9XM;?(",
    database:"dibbs"
})


var app = express()
app.use(cors())
app.use(express.json())

app.post("/createroom", (req, res, next) =>
{
    let strRoomNumber = req.body.RoomNumber
    console.log(strRoomNumber)
    let strCapacity = req.body.Capacity
    console.log(strCapacity)
    let strEquipment = req.body.Equipment
    console.log(strEquipment)
    let strActive = req.body.Active
    console.log(strActive)

    //let strCommand = 'SELECT * FROM tblClassrooms'
    let strCommand = 'INSERT INTO tblClassrooms (RoomNumber, Capacity, Equipment, Active) VALUES (?, ?, ?, ?);'
    
    conDibbs.getConnection(function(err, connection)
    { 
        if (err) // CHECK IF CONNECTION IS SUCCESSFUL
        {
            console.log(err)
            res.status(500).json({status:"error", message:err})
        }
        else
        {
            conDibbs.query(strCommand, [strRoomNumber, strCapacity, strEquipment, strActive], function(err, result) // RUN SQL COMMAND THAT DOESN'T HAVE ANY FOREIGN KEY REQUIREMENTS
            {
                if (err)
                {
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                }
                else
                {
                    res.status(201).json({status:"success",RoomNumber:strRoomNumber})
                }
            })
        }
        connection.release() // RELEASE  CONNECTION TO DATABASE
    })
})

app.get('/retreiverooms', (req, res, next) =>
{
    let strCommand = 'SELECT * FROM tblClassrooms'
    console.log("Sent Request")
    conDibbs.getConnection(function(err, connection)
    {
        if (err)
        {
            console.log(err)
            res.status(500).json({status:"error",message:err})
        }
        else
        {
            conDibbs.query(strCommand, function(err, result)
            {
                if (err)
                {
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                }
                else
                {
                    res.status(200).json(result)
                }
            })
        }
        connection.release()
    })
    console.log("Got Request")
})

app.post("/createreservation", (req, res, next) =>
{
    let strClassroomID = req.body.ClassroomID
    let strUserID = req.body.UserID

    let strInsertCommand = "INSERT INTO tblReservations (ClassroomID, UserID, StartDateTime, EndDateTime) VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR));" // set resservation time to be 2 hours after
    let strCheckUsersCommand = "SELECT COUNT(*) AS TotalUsers FROM tblUsers WHERE UserID=?;" // FUFILL USERS FOREIGN KEY REQUIREMENTS
    let strCheckClassroomsCommand = "SELECT COUNT (*) AS TotalClassrooms FROM tblClassrooms WHERE ClassroomID=?;" // FUFILL CLASSROOMS FOREIGN KEY REQUIREMENTS

    conDibbs.getConnection(function(err, connection) // GET CONNECCTION
    {
        if (err) // IF WE ERROR OUT OF A CONNECTION
        {
            console.log(err)
            res.status(500).json({status:"error",message:err})
        }
        else
        {
            conDibbs.query(strCheckUsersCommand, [strUserID], function(err, resultUsers) // WE ANT TO CHECK IF THE USER EXISTS
            {
                if (resultUsers[0]['TotalUsers'] <= 0) // WE CAN CHECK BY CHECKING THE  COUNT OF THE NUMBER OF ENTRIES CONTAINING THE USER AGAINST 0
                {
                    res.status(500).json({status:"error",message:"User does not exist"})
                }
                else
                {
                    if (err) // CHECK IF THE QUERY FAILED 
                    {
                        console.log(err)
                        res.status(500).json({status:"error",message:err})
                    }
                    else
                    {
                        conDibbs.query(strCheckClassroomsCommand, [strClassroomID], function(err, resultClassrooms) // WANT TO CHECK IF CLASSROOM EXISTS
                        {
                            if (err)
                            {
                                console.log(err)
                                res.status(500).json({status:"error",message:err})
                            }
                            else
                            {
                                if (resultClassrooms[0]['TotalClassrooms'] <= 0) // WE CAN CHECK AGAIN BY CHECKING THE COUNT OF THE NUMBER OF ENTRIES CONTAINING THE SPECIFIC CLASSROOM AGAINST 0
                                {
                                    res.status(500).json({status:"error",message:"Classroom does not exist"})
                                }
                                else
                                {
                                    conDibbs.query(strInsertCommand, [strClassroomID, strUserID], function(err, result) // INSERT INTO DATA IF ALL FOREIGN KEYS REQUIREMENTS ARE MET
                                    {
                                        if (err) // CHECK IF INSERT QUERY FAILED
                                        {
                                            console.log(err)
                                            res.status(500).json({status:"error",message:err})
                                        }
                                        else
                                        {
                                            res.status(201).json({status:"successful reservation created",message:"Reservation created"})
                                        }
                                    })
                                    console.log("Successful Classroom Access: ", strClassroomID) // SUCCESS LOG SUCCESSFUL CLASSROOM  CHECK TO TERMINAL 
                                }
                            }       
                        })
                    }
                    console.log("Successful UserCheck: ", strUserID) // SUCCESS LOG  SUCCESSFUL USER CHECK TO TERMINAL 
                }
            })
        }
        connection.release() // RELEASE CONNECTION TO DATABASE
    })
})

app.get("/retrievereservations", (req, res, next) => 
{
    let strCommand = 'SELECT * FROM tblReservations'
    console.log("Sent Request")
    conDibbs.getConnection(function(err, connection)
    {
        if (err)
        {
            console.log(err)
            res.status(500).json({status:"error",message:err})
        }
        else
        {
            conDibbs.query(strCommand, function(err, result)
            {
                if (err)
                {
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                }
                else
                {
                    res.status(200).json(result)
                }
            })
        }
        connection.release()
    })
    console.log("Got Request")
})

app.post("/sessions",(req,res,next) => {
    let strEmail = req.body.Email;
    let strPassword = req.body.Password;
    let strSessionID = uuidv4();
    let strCommand = "SELECT COUNT(*) AS TotalUsers FROM tblUsers WHERE Email = ? AND Password = ?"
    let strCommand2 = "INSERT INTO tblSessions VALUES (?,NOW(),?)"
    conDibbs.getConnection(function(err,connection){
        if(err)
        {
            console.log(err);
            res.status(500).json({status:"error",message:err})
        }
        else 
        {
            conDibbs.query(strCommand,[strEmail,strPassword],function(err,result){
                if(err)
                {
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                }
                else 
                {
                    if(result[0]['TotalUsers'] > 0)
                    {
                        conDibbs.query(strCommand2,[strSessionID,strEmail],function(err,result)
                        {
                            if(err)
                            {
                                console.log(err)
                                res.status(500).json({status:"error",message:err})
                            } 
                            else 
                            {
                                res.status(201).json({status:"success",sessionid:strSessionID})
                            }
                        })
                    } 
                    else 
                    {
                        res.status(401).json({status:"error",message:"Invalid Credentials"})
                    }
                    res.status(201).json({status:"success",userid:strUserID})
                }
            })
        }
    })
})

app.post("/users",(req,res,next) => {
    let strFirstName = req.body.FirstName;
    let strLastName = req.body.LastName;
    let strPassword = req.body.Password;
    let strEmail = req.body.Email;
    let strUserID = uuidv4();
    let strCommand = "INSERT INTO tblUsers VALUES (?,?,?,?,1,?)"
    conDibbs.getConnection(function(err,connection)
    {
        if(err)
        {
            console.log(err);
            res.status(500).json({status:"error",message:err})
        } 
        else 
        {
            conDibbs.query(strCommand,[strUserID,strEmail,strFirstName,strLastName,strPassword],function(err,result)
            {
                if(err)
                {
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                }
                else
                {
                    res.status(201).json({status:"success",userid:strUserID})
                }
            })
        }
    })
})

app.get("/hello",(req,res,next) =>{
    let strCommand = 'SELECT * FROM tblUsers'
    conDibbs.getConnection(function(err,connection){
        if(err){
            console.log(err)
            res.status(500).json({status:"error",message:err})
        } else {
            conDibbs.query(strCommand,function(err,result){
                if(err){
                    console.log(err)
                    res.status(500).json({status:"error",message:err})
                } else {
                    res.status(200).json(result)
                }
            })
        }
        connection.release();
    })
})

app.get("/goodbye",(req,res,next) => {
    res.status(200).json({message:"Goodbye World"})
})

app.get("/goodbyename",(req,res,next) => {
    let strName = req.query.name
    res.status(200).json({message:"Goodbye " + strName})
})

app.get("/name",(req,res,next) => {
    let strName = req.query.name 
    res.status(200).json({message:"Hello " + strName})
})

app.listen(HTTP_PORT, () => {
    console.log('App listening on port', HTTP_PORT)
})