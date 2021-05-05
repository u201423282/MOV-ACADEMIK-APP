package com.example.academik;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.CalendarView;

public class HorarioActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_horario);

        CalendarView simpleCalendarView = (CalendarView) findViewById(R.id.cvHorario);
        simpleCalendarView.setFirstDayOfWeek(1);



    }




}