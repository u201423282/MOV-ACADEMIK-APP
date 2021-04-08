package com.example.academik;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ActionBar;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class LoginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportActionBar().hide();
        setContentView(R.layout.activity_login);

    }

    public void f_login(View v){
        Intent i = new Intent(this,MenuNavigateActivity.class);
        i.putExtra("TOKEN","123456");

        startActivity(i);
    }

}