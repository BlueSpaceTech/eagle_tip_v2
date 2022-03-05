import * as functions from "firebase-functions";

import * as admin from 'firebase-admin';
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
        return fcm.sendToCondition("'SiteManager' in topics || 'SiteUser' in topics",payload);
        // return fcm.sendToTopic
    });
