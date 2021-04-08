package com.example.academik;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;

import com.example.academik.Fragments.ComunicadosFragment;
import com.example.academik.Fragments.CursosFragment;
import com.example.academik.Fragments.HorarioFragment;
import com.example.academik.Fragments.NotasFragment;
import com.example.academik.Fragments.PerfilFragment;
import com.example.academik.Fragments.UbicanosFragment;
import com.google.android.material.navigation.NavigationView;

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
        menuLayout = findViewById(R.id.menuDesplegable);
        navigationView = findViewById(R.id.navigationView);
        actionBarDrawerToggle = new ActionBarDrawerToggle(this,menuLayout,toolbar,R.string.open,R.string.close);

        navigationView.setNavigationItemSelectedListener(this);

        menuLayout.addDrawerListener(actionBarDrawerToggle);
        actionBarDrawerToggle.setDrawerIndicatorEnabled(true);
        actionBarDrawerToggle.syncState();

        //Cargar Fragment Principal
        fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.add(R.id.container, new PerfilFragment());
        fragmentTransaction.commit();
    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        menuLayout.closeDrawer(GravityCompat.START);
        Log.i("---->",""  + item.getItemId());

        if(item.getItemId() == R.id.perfil){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new PerfilFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.curso){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new CursosFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.nota){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new NotasFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.horario){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new HorarioFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.comunicado){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new ComunicadosFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.ubicacion){
            fragmentManager = getSupportFragmentManager();
            fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, new UbicanosFragment());
            fragmentTransaction.commit();
        }
        if(item.getItemId() == R.id.contacto){

        }




        return false;
    }
}