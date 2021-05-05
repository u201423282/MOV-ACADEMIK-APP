package com.example.academik;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.academik.Fragments.ComunicadosFragment;
import com.example.academik.Fragments.CursosFragment;
import com.example.academik.Fragments.HorarioFragment;
import com.example.academik.Fragments.NotasFragment;
import com.example.academik.Fragments.PerfilFragment;
import com.example.academik.Fragments.UbicanosFragment;
import com.google.android.material.navigation.NavigationView;

import org.w3c.dom.Text;

public class MenuNavigateActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener{

    DrawerLayout menuLayout;
    ActionBarDrawerToggle actionBarDrawerToggle;
    Toolbar toolbar;
    NavigationView navigationView;

    // Variables para cargar el fragment principal
    FragmentManager fragmentManager;
    FragmentTransaction fragmentTransaction;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_navigate);

        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        //CARGAR DATOS DEL FRAGMENT PRINCIPAL
        fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.add(R.id.container, new PerfilFragment());
        fragmentTransaction.commit();

        menuLayout = findViewById(R.id.menuDesplegable);
        navigationView = findViewById(R.id.navigationView);
        actionBarDrawerToggle = new ActionBarDrawerToggle(this,menuLayout,toolbar,R.string.open,R.string.close);
        navigationView.setNavigationItemSelectedListener(this);
        menuLayout.addDrawerListener(actionBarDrawerToggle);
        actionBarDrawerToggle.setDrawerIndicatorEnabled(true);
        actionBarDrawerToggle.syncState();

        //CARGAR DATOS DEL PERFIL.
        TextView codigo = navigationView.getHeaderView(0).findViewById(R.id.ctvCodigoAlumno);
        TextView nombre = navigationView.getHeaderView(0).findViewById(R.id.ctvNombreAlumno);
        SharedPreferences prefs = getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String nombreShared = prefs.getString("nombre", "");
        String codigoShared = prefs.getString("codigo", "");
        nombre.setText(nombreShared);
        codigo.setText(codigoShared);

    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        menuLayout.closeDrawer(GravityCompat.START);
        Log.i("---->",""  + item.getItemId());

        if(item.getItemId() == R.id.contacto){
            SharedPreferences prefs = getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
            String telefonoSede = prefs.getString("telefenoSede", "");

            Intent i = new Intent(Intent.ACTION_DIAL);
            i.setData(Uri.parse("tel:"+telefonoSede));
            startActivity(i);
        }
        else{
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();

            if(item.getItemId() == R.id.perfil){
                fragmentTransaction.replace(R.id.container, new PerfilFragment());
            }
            if(item.getItemId() == R.id.curso){
                fragmentTransaction.replace(R.id.container, new CursosFragment());
            }
            if(item.getItemId() == R.id.nota){
                fragmentTransaction.replace(R.id.container, new NotasFragment());
            }
            if(item.getItemId() == R.id.horario){
                fragmentTransaction.replace(R.id.container, new HorarioFragment());
            }
            if(item.getItemId() == R.id.comunicado){
                fragmentTransaction.replace(R.id.container, new ComunicadosFragment());
            }
            if(item.getItemId() == R.id.ubicacion){
                fragmentTransaction.replace(R.id.container, new UbicanosFragment());
            }
            fragmentTransaction.commit();

        }

        return false;
    }
}