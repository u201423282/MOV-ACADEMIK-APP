package com.example.academik.utilitario;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.core.app.NotificationCompat;

import com.example.academik.DAO.ComunicadoDAO;
import com.example.academik.DAO.DAOException;
import com.example.academik.MainActivity;
import com.example.academik.MenuNavigateActivity;
import com.example.academik.R;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class MyAndroidFirebaseMsgService extends FirebaseMessagingService {

    String var_titulo;
    String var_fecha;
    String var_descripcion;

    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Log.d("====>","NEW_TOKEN: "+token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {

        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

        super.onMessageReceived(remoteMessage);
        Log.i("==========>", "De: " + remoteMessage.getFrom());
        Log.i("==========>", "Title: " + remoteMessage.getNotification().getTitle());
        Log.i("==========>", "Fecha: " + dateFormat.format(date).toString());
        Log.i("==========>", "Mensaje: " + remoteMessage.getNotification().getBody());

        var_titulo = remoteMessage.getNotification().getTitle().toString();
        var_fecha = dateFormat.format(date).toString();
        var_descripcion = remoteMessage.getNotification().getBody().toString();

        if (remoteMessage.getData().size() > 0) {
            Log.i("======>", "Message data payload: " + remoteMessage.getData());
            Map<String, String> data = remoteMessage.getData();
        } else if (remoteMessage.getNotification() != null) {
            Log.i("======>", "Message Notification Body: " + remoteMessage.getNotification().getBody());
            createNotification(remoteMessage.getNotification().getBody());
            grabarComunicado(var_titulo,var_fecha,var_descripcion);
        }

    }

    private void createNotification( String messageBody) {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        String NOTIFICATION_CHANNEL_ID = "my_channel_id_01";

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            int importance = NotificationManager.IMPORTANCE_DEFAULT;
            NotificationChannel channel = new NotificationChannel("my_channel_id_01", "my_channel_id_01", importance);
            channel.setDescription("my_channel_id_01");
            notificationManager = getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }


        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID);
        Intent intent = new Intent( this , MenuNavigateActivity.class );
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);


        PendingIntent actionPendingIntent = PendingIntent.getActivity(this,1,intent,PendingIntent.FLAG_UPDATE_CURRENT);

        notificationBuilder.setAutoCancel(true)
                .setDefaults(Notification.DEFAULT_ALL)
                //.addAction(R.drawable.common_google_signin_btn_icon_light, "ACEPTAR", actionPendingIntent)
                //.setWhen(System.currentTimeMillis())
                .setContentIntent(actionPendingIntent)
                .setSmallIcon(R.mipmap.ic_launcher_round)
                .setBadgeIconType(NotificationCompat.BADGE_ICON_LARGE)
                .setContentTitle(var_titulo)
                //.setSound(Uri.parse("android.resource://"+getPackageName()+"/" + R.raw.beeep))
                .setContentText(messageBody)
                .setAutoCancel(true)
                .setContentInfo("SMART");

        notificationManager.notify(/*notification id*/1, notificationBuilder.build());
    }

    public void grabarComunicado(String titulo, String fecha, String descripcion) {

        ComunicadoDAO dao = new ComunicadoDAO(getBaseContext());
        try {

            dao.insertar(titulo.toString(),fecha.toString(), descripcion.toString());
            Log.i("Insert", "Comunicado registrado");
        } catch (DAOException e) {
            Log.i("GeneroMusicalNuevoActi", "====> " + e.getMessage());
        }
    }



}
