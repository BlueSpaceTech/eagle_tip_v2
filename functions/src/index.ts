import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as firebaseHelper from 'firebase-functions-helper';
import * as express from 'express';
import * as bodyParser from 'body-parser';
import * as schedule from 'node-schedule';
admin.initializeApp(functions.config().firebase);

const db= admin.firestore();
const fcm =admin.messaging();

// export const heeloworld = functions.https.onRequest((request,response)=>{
//     functions.logger.info("Hello log!",{structuraldata:true});
//     response.send("Rakshit kamboj!");
// });
const app=express();
const main=express();



// const requestsCollection= 'requesthistory';
// main.use('/api/v1',app);
// main.use(bodyParser.json());
// main.use(bodyParser.urlencoded({
//     extended:false
// }));

// export const webApi=functions.https.onRequest(main);
// console.log(main.path);
// app.post('/requesthistory/', async (req, res) => {
//     try {
//         const request = {
//             firstName: req.body['date'],
//             // lastName: req.body['lastName'],
//             // email: req.body['email']
//         }
// const newDoc = await firebaseHelper.firestoreHelper
//             .createNewDocument(db, requestsCollection, request);
//         res.status(201).send(`Created a new contact: ${newDoc.id}`);
//     } catch (error) {
//         res.status(400).send(`Contact should only contains firstName, lastName and email!!!`)
//     }        
// })
// app.get('/requesthistory/',(req,res)=>{
//     firebaseHelper.firestoreHelper.backup("/requesthistory/").then(data=>res.status(200).send(data)).catch(error=>res.status(400).send("Cannot get request data",));
//     console.log(firebaseHelper.firestoreHelper.backup("/requesthistory").then(data=>data));
// });

export const schedfunc=functions.pubsub.schedule("every 5 minutes").onRun(async (context)=>{
    const query =await db.collection("notifications").where('scheduledTime','<=',admin.firestore.Timestamp.now()).get();
    const documents=query.docs;
    documents.forEach((element)=>{
        db.collection("pushNotifications").doc().set(element.data());
        db.collection("notifications").doc(element.id).delete();
    })
    console.log(admin.firestore.Timestamp.now());
    console.log("document added");
    
}
    
);

exports.deleteUser=functions.firestore.document("users/{userID}").onDelete(async(snap,context)=>{
    return admin.auth().deleteUser(snap.id).then(()=>console.log('Deleted User with ID:'+snap.id)).catch((err)=>console.error('There was an error while deleting the user:',err));
})

export const sendToCondition =functions.firestore.document('/pushNotifications/{notificaitonId}').onCreate(async snapshot=>{
        const notify=snapshot.data();
        const payload: admin.messaging.MessagingPayload={
            notification:{
                title: `${notify.title}`,
                body:`${notify.description}`
    
            }
        };

        function returnTopic(){
            let topicname:string="";
            for(let i=0;i<notify.visibleto.length;i++){
                if(notify.sites.length==0){
                    if(notify.visibleto[i]==notify.visibleto[notify.visibleto.length-1]){
                        topicname+="'"+`${notify.visibleto[i]}`+"'"+" in topics";
                    }else{
                        topicname+="'"+`${notify.visibleto[i]}`+"'"+" in topics || ";
                    }
    
    
                }else{
                    for(let j=0;j<notify.sites.length;j++){
                        if((i==notify.visibleto.length-1)&&(j==notify.sites.length-1)){
                            topicname+="'"+`${notify.visibleto[i]+notify.sites[j].replace(/\s/g, "")}`+"'"+" in topics";
                        }else{
                            topicname+="'"+`${notify.visibleto[i]+notify.sites[j].replace(/\s/g, "")}`+"'"+" in topics || ";
                        }
                    }
                }
            }
            return topicname;
        }
       
            return fcm.sendToCondition(returnTopic(),payload);
      
      
        // return fcm.sendToTopic
    });


exports.emptyArr=
    functions.firestore.document('/termconditions/{id}').onUpdate(async snapshot=>{
        return snapshot.after.ref.collection("dialog").doc("yFXxdJGVDUkgU8o8hCUU").update({
            "viewedby":[]
        });
        
    })


