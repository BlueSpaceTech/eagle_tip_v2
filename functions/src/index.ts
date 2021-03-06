import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as firebaseHelper from 'firebase-functions-helper';
import * as express from 'express';
import * as bodyParser from 'body-parser';
import * as schedule from 'node-schedule';
admin.initializeApp(functions.config().firebase);
import fetch from "node-fetch";
import { raw } from "body-parser";
import { topic } from "firebase-functions/v1/pubsub";

const db= admin.firestore();
const fcm =admin.messaging();
const app=express();
const main=express();



export const notifyatnine=functions.pubsub.schedule("0 21 * * *").timeZone('America/New_York').onRun(async (context)=>{
    let allsites :any=[];
let rawdata=[];
   try{
    rawdata= await fetch("https://rhjjm90yii.execute-api.us-east-1.amazonaws.com/default/web_inventory_station_data",{
        headers:{
            'x-api-key':'TWGR2Kt4eb2LlsY1Y0VO474zOQnwz04o3sFnn4q5',
        }
    }).then(response => response.json()) as any;
    for(let i=0;i<rawdata.length;i++){
        allsites.push(rawdata[i]["CONNAM"]);
    }
    // console.log(sites);
    
   }catch(error){
    console.log("Error fetching data from API Call: "+error);
   }
   const doc = await db.collection("9pmNotifys").doc("notifs").get();
   let sitesrequested : any= doc.data();
   sitesrequested= doc.get("sites");
   let notifysites : any=[];
    for(let i=0;i<allsites.length;i++){
        if(!sitesrequested.includes(allsites[i])){
            notifysites.push(allsites[i]);
        }
    }



    for(let i=0;i<notifysites.length;i++){
    const payload: admin.messaging.MessagingPayload={
        notification:{
            title: "Eagle TIP Reminder: ",
            body:`Remember to submit your inventory request for: ${notifysites[i]}`
    
            }
        };
        let topicname:string ="";
        topicname+="SiteManager"+`${notifysites[i].replace(/\s/g, "")}`;
        console.log(topicname);
        fcm.sendToTopic(topicname,payload);
    }
});


export const schedfunc=functions.pubsub.schedule("every 1 minutes").onRun(async (context)=>{
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

      
          
        for(let i=0;i<notify.visibleto.length;i++){
               
                    
            for(let j=0;j<notify.sites.length;j++){
                let topicname="";
                    topicname+=`${notify.visibleto[i]+notify.sites[j].replace(/\s/g, "")}`;
                    fcm.sendToTopic(topicname,payload);
                
            }
        
        

    }
            // return topicname;
        
       
            // return fcm.sendToCondition(returnTopic(),payload);
                
      
        // return fcm.sendToTopic
    });


exports.emptyArr=
    functions.firestore.document('/termconditions/{id}').onUpdate(async snapshot=>{
        return snapshot.after.ref.collection("dialog").doc("yFXxdJGVDUkgU8o8hCUU").update({
            "viewedby":[]
        });
        
    })

exports.emptysitesArr=
functions.pubsub.schedule("0 0 * * *").timeZone("America/New_York").onRun(async (context)=>{
    return db.collection("9pmNotifys").doc("notifs").update({
        "sites":[]
    });
})


