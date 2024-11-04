var strAPIURL = "http://localhost:8000/";
function isValidEmail(strEmail){
    const regEmail = /^\S+@\S+\.\S+$/;
    return regEmail.test(strEmail);
}

function isValidPassword(strPassword){
    const regPassword = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{16,}$/;
    return regPassword.test(strPassword);
}

function convertFileToBase64(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = reject;
  });
}

async function wsCall(strType, strURL, objBody) {
    var reqTemp;
    if(strType == 'GET' || strType == 'DELETE'){
        reqTemp = new Request(strAPIURL + strURL, {
            method: strType,
            headers: {
              "Content-Type": "application/json",
            },
        })
    } else {
        reqTemp = new Request(strAPIURL + strURL, {
            method: strType,
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(objBody),
        });
    }
    if(typeof strSessionID !== 'undefined'){
      try {
        const response = await fetch(reqTemp,
          {
              headers: {Authorization: 'Bearer ' + strSessionID, 'Content-Type': 'application/json'}
          }
        );
        const result = await response.json();
        return result;
      } catch (error) {
        console.error(error);
        return error;
      }
    } else {
      try {
        const response = await fetch(reqTemp);
        const result = await response.json();
        return result;
      } catch (error) {
        console.error(error);
        return error;
      }
    }
    
}
