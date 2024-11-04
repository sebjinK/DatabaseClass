const express = require('express') // handles http requests and hands something back form those requeusts
const cors  = require('cors') // who has access to the webseerver
const mysql = require('mysql') // who has access to mysql
const {v4:uuidv4} = require('uuid') // generate UUIDs to put in database

const HTTP_PORT = 8000

const conDibbs = mysql.createPool
(
    {
        host:"localhost",
        user:"root",
        password:"p21aA£9XM;?(",
        database:"dibbs"
    }
)

var app = express()
app.use(cors())
app.use(express.json())

app.post("/users", (req, res, next) =>
{
    let strFirstName = req.body.FirstName
    console.log(strFirstName)
    let strLastName = req.body.LastName
    console.log(strLastName)
    let strPassword = req.body.Password
    console.log(strPassword)
    let strEmail = req.body.Email
    console.log(strEmail)
    let strUserID = uuidv4()
    
    let strCommand = "INSERT INTO tblUsers VALUES(?,?,?,?,1,?)" // five question marks for five inputs
    conDibbs.getConnection(function(err, connection){
        if (err) 
        {
            console.log(err)
            res.status(500).json({status:"error", message:err})
        }
        else
        {
            conDibbs.query(strCommand, [strUserID,strEmail,strFirstName,strLastName,strPassword], 
            function(err,result)
            {
                if (err)
                {
                    console.log(err)
                    res.status(500).json({status:"error", message:err})
                }
                else
                {
                    res.status(201).json({status:"success",userdi:strUserID})
                }
            })
        }
        connection.release()
    })
})

app.get("/hello", (req, res, next) => 
{ //request, response, next
    let strConnect = "SELECT * FROM tblEvents"
    conDibbs.getConnection(function(err, connection) 
    {
        if (err)
        {
            console.log(err)
            res.status(500).json({status:"error", message:err})
        }
        else
        {
            conDibbs.query(strConnect, function(err,result)
            {
                if (err)
                {
                    console.log(err)
                    res.status(500).json({status:"error", message:err})
                }
                else
                {
                    res.status(200).json(result)
                }
            })
        }
        connection.release()
    })    // res.status(200).json({message:"Hello World"})
}) // message server to get something from database
// app.post() // get something from database
// app.put()
app.get("/goodbye", (req, res, next) => { // request, response, next
        res.status(200).json({message:"Goodbye, World"})
    }
)

app.get("/name", (req, res, next) => {
        let strName = req.query.name 
        res.status(200).json({message: "Hello " + strName})
    }
)

app.get("/goodbyeName", (req, res, next) => {
        let strName = req.query.name
        res.status(200).json({message: "Goodbye " + strName})
    }

)

app.listen(HTTP_PORT, () => {
    console.log("Listening on Port: ", HTTP_PORT)
    }
)
