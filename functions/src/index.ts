import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

export const novaTorcida = functions.firestore
                                    .document('usuarios/{userId}')
                                    .onWrite(contador);

async function contador(change: any, context: any) {
  const valorAntigo = change.before.exists ? change.before.data() : null;
  const valorNovo = change.after.exists ? change.after.data() : null;

  if(valorAntigo != null && valorAntigo.time_id == valorNovo.time_id) {
    return null;
  }

  var batch = db.batch();

  var timeNovoRef = db.doc(`times/${valorNovo.time_id}`);
  batch.set(timeNovoRef, {torcedores: admin.firestore.FieldValue.increment(1)}, {merge: true});

  if(valorAntigo != null) {
    var timeAntigoRef = db.doc(`times/${valorAntigo.time_id}`);
    batch.set(timeAntigoRef, { torcedores: admin.firestore.FieldValue.increment(-1) }, { merge: true });
  }  

  return await batch.commit();
}

// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

