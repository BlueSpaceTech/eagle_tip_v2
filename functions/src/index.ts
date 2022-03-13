import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as schedule from 'node-schedule';
admin.initializeApp();

const db= admin.firestore();
const fcm =admin.messaging();



export const schedfunc=functions.pubsub.schedule("* * * * *").onRun(async (context)=>{
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
                    for(let j=0;notify.sites.length;j++){
                        if((i==notify.visibleto.length-1)&&(j==notify.sites.length-1)){
                            topicname+="'"+`${notify.visibleto[i]}`+`${notify.sites[j].replace(/\s/g, "")}`+"'"+" in topics";
                        }else{
                            topicname+="'"+`${notify.visibleto[i]}`+`${notify.sites[j].replace(/\s/g, "")}`+"'"+" in topics || ";
                        }
                    }
                }
            }
            return topicname;
        }
       
            return fcm.sendToCondition(returnTopic(),payload);
      
      
        // return fcm.sendToTopic
    });





