import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as schedule from 'node-schedule';
admin.initializeApp();

const db= admin.firestore();
const fcm =admin.messaging();



export const sendToCondition =functions.firestore.document('/notifications/{notificaitonId}').onCreate(async snapshot=>{
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
                if(notify.visibleto[i]==notify.visibleto[notify.visibleto.length-1]){
                    topicname+="'"+`${notify.visibleto[i]}`+"'"+" in topics";
                }else{
                    topicname+="'"+`${notify.visibleto[i]}`+"'"+" in topics || ";
                }
            }
            return topicname;
        }
       
            return fcm.sendToCondition(returnTopic(),payload);
      
      
        // return fcm.sendToTopic
    });


exports.setdocument=functions.region("us-central1").https.onCall(async (data,context)=>{
        return functions.pubsub.schedule("every 2 minutes").onRun( async (context)=>
        console.log("tesy")
        // await db.doc("/notifications/{notificaitonId}").set({
        //     "title":data.title,
        //     "sites":data.sites,
        //     "description":data.description,
        //     "visibleto":data.visibleto,
        //     "createdby":data.role,
        //     "scheduledDateandTime":data.timenow,
        // })
        );
                        
                    
            });
exports.schedulefunc=functions.pubsub.schedule("every 1 minutes").onRun((context)=>
console.log("Test"));