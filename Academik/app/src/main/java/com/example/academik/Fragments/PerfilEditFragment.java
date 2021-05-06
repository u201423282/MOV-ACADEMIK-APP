package com.example.academik.Fragments;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.ActivityNotFoundException;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.MimeTypeMap;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.amazonaws.util.IOUtils;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.academik.R;
import com.example.academik.bean.LogueoBean;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PerfilEditFragment extends Fragment {

    private static final int REQUEST_EXTERNAL_STORAGE = 1;
    private static String[] PERMISSIONS_STORAGE = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
    };

    private static final int ACTIVITY_START_CAMERA_APP = 1;
    private static final int RESULT_OK = 1;
    TextView actPerfilText;
    EditText telefonoText;
    EditText correoText;
    public static final int PICK_IMAGE = 1;
    static final int REQUEST_IMAGE_CAPTURE = 1;
    TextView tvFileName;

    private Bitmap bitmap;

    private String mImageFileLocation = "";
    ImageView imageView3;

    public Context context = this.getContext();

    ProgressDialog progressDialog;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_perfil_edit,container,false);
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String nombre = prefs.getString("nombre", "");
        String codigo = prefs.getString("codigo", "");
        String telefono = prefs.getString("telefono", "");
        String correoalumno = prefs.getString("correoalumno", "");

        EditText codigoText = (EditText) view.findViewById(R.id.etCodigoAlumno);
        EditText nombreText = (EditText) view.findViewById(R.id.etNombre);
        telefonoText = (EditText) view.findViewById(R.id.etTelefono);
        correoText = (EditText) view.findViewById(R.id.etCorreo);
        actPerfilText = (TextView) view.findViewById(R.id.msgActPerfil);

        nombreText.setText(nombre);
        codigoText.setText(codigo);
        telefonoText.setText(telefono);
        correoText.setText(correoalumno);

        imageView3 = (ImageView) view.findViewById(R.id.imageView3);

        Button button = (Button) view.findViewById(R.id.btnSave);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                AlertDialog.Builder dialogo1 = new AlertDialog.Builder(v.getContext());
                dialogo1.setTitle("Confirmación");
                dialogo1.setMessage("¿ Desea actualizar los datos ?");
                dialogo1.setCancelable(false);
                dialogo1.setPositiveButton("Confirmar", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialogo1, int id) {
                        aceptar();
                    }
                });
                dialogo1.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialogo1, int id) {
                        cancelar();
                    }
                });
                dialogo1.show();

            }
        });

        Button btnGalery= (Button) view.findViewById(R.id.btnUploadGalery);
        btnGalery.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                cargar(v);
            }
        });

        tvFileName = (TextView) view.findViewById(R.id.tv_file_name);
        tvFileName.setText("");

        try {
            Amplify.addPlugin(new AWSCognitoAuthPlugin());
            Amplify.addPlugin(new AWSS3StoragePlugin());
            Amplify.configure(this.getContext());
            Log.i("MyAmplifyApp", "Initialized Amplify");

        } catch (AmplifyException e) {
            Log.e("MyAmplifyApp", "Could not initialize Amplify", e);
        }

        dowload();
        return view;
    }

    public static void verifyStoragePermissions(Activity activity) {
        // Check if we have write permission
        int permission = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);

        if (permission != PackageManager.PERMISSION_GRANTED) {
            // We don't have permission so prompt the user
            ActivityCompat.requestPermissions(
                    activity,
                    PERMISSIONS_STORAGE,
                    REQUEST_EXTERNAL_STORAGE
            );
        }
    }

    public void aceptar(){
        actPerfilText.setText("Actualizando...");
        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String idpersona = prefs.getString("idpersona", "");
        String telefono = telefonoText.getText().toString();
        String correoalumno = correoText.getText().toString();

        try {
            String URL = "http://20.83.224.206:9082/servicesREST/Persona/actualizarEstudiante";
            JSONObject jsonBody = new JSONObject();

            jsonBody.put("idPersona", Integer.parseInt(idpersona));
            jsonBody.put("correoPersonal", correoalumno);
            jsonBody.put("telefono", telefono);

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Log.i("======>",response);

                    if(Integer.parseInt(response) == 200 ){
                        SharedPreferences.Editor editor = prefs.edit();
                        editor.putString("correoalumno", correoalumno);
                        editor.putString("telefono", telefono);
                        editor.commit();

                        Fragment fragment = new PerfilFragment();
                        FragmentManager fragmentManager = getActivity().getSupportFragmentManager();
                        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                        fragmentTransaction.replace(R.id.container, fragment);
                        fragmentTransaction.addToBackStack(null);
                        fragmentTransaction.commit();

                    }

                    progressDialog.dismiss();

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progressDialog.dismiss();
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public byte[] getBody() throws AuthFailureError {
                    try {
                        return mRequestBody == null ? null : mRequestBody.getBytes("utf-8");
                    } catch (UnsupportedEncodingException uee) {
                        VolleyLog.wtf("Unsupported Encoding while trying to get the bytes of %s using %s", mRequestBody, "utf-8");
                        return null;
                    }
                }

                @Override
                protected Response<String> parseNetworkResponse(NetworkResponse response) {
                    String responseString = "";
                    if (response != null) {
                        responseString = String.valueOf(response.statusCode);
                    }
                    return Response.success(responseString, HttpHeaderParser.parseCacheHeaders(response));
                }
            };
            RequestQueue requestQueue = Volley.newRequestQueue(this.getContext());
            requestQueue.add(stringRequest);
            stringRequest.setRetryPolicy(new DefaultRetryPolicy(30 * 1000, 1, 1.0f));
            progressDialog = new ProgressDialog(getActivity());
            progressDialog.setTitle("Perfil");
            progressDialog.setMessage("Actualizando...");
            progressDialog.show(); // Display Progress Dialog
            progressDialog.setCancelable(false);

        } catch (JSONException e) {
            e.printStackTrace();
        }

    }

    public void cancelar(){

    }

    private String getRealPathFromURI(Uri contentURI) {
        String result;
        Cursor cursor = this.getActivity().getContentResolver().query(contentURI, null, null, null, null);
        if (cursor == null) { // Source is Dropbox or other similar local file path
            result = contentURI.getPath();
        } else {
            cursor.moveToFirst();
            int idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA);
            result = cursor.getString(idx);
            cursor.close();
        }
        return result;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PICK_IMAGE ) {

            Uri selectedImageURI = data.getData();
            String ruta = getRealPathFromURI(selectedImageURI);

            SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
            String codigoAlumno = prefs.getString("codigo", "");
            final String fileName = codigoAlumno+".jfif";

            File file = null;
            try {
                file = new File(ruta);
                if (!file.exists()) {
                    file.mkdir(); // create dir here
                    file.createNewFile();
                }

                bitmap = BitmapFactory.decodeFile(ruta);
                imageView3.setImageBitmap(bitmap);

            } catch (IOException e) {
                e.printStackTrace();
            }
            verifyStoragePermissions(this.getActivity());
            Amplify.Storage.uploadFile(
                    fileName,
                    file,
                    result -> {tvFileName.setText("Foto actualizada");
                        Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey());},
                    storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
            );
        }

    }

    public void cargar(View v) {

        AlertDialog.Builder dialogo1 = new AlertDialog.Builder(v.getContext());
        dialogo1.setTitle("Actualizar Foto");
        dialogo1.setMessage("¿ Desea actualizar su foto ?");
        dialogo1.setCancelable(false);
        dialogo1.setPositiveButton("Confirmar", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialogo1, int id) {

                Intent intent = new Intent();
                intent.setType("image/*");
                intent.setAction(Intent.ACTION_GET_CONTENT);
                startActivityForResult(Intent.createChooser(intent, "Select Picture"), PICK_IMAGE);
            }
        });
        dialogo1.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialogo1, int id) {
                cancelar();
            }
        });
        dialogo1.show();


    }

    public void dowload() {

        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String codigoAlumno = prefs.getString("codigo", "");
        final String fileName = codigoAlumno+".jfif";
        Log.i("codigo : ", fileName);
        Amplify.Storage.downloadFile(
                fileName,
                new File(this.getActivity().getApplicationContext().getFilesDir() + fileName),
                result -> {
                    Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName());
                    bitmap = BitmapFactory.decodeFile(result.getFile().getAbsolutePath());
                    imageView3.setImageBitmap(bitmap);
                },
                error -> {tvFileName.setText("");}
        );
    }

}
