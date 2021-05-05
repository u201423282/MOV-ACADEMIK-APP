package com.example.academik.Fragments;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.academik.R;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class UbicanosFragment extends Fragment implements OnMapReadyCallback {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_ubicanos,container,false);

        MapView mapView = view.findViewById(R.id.map_view);
        mapView.onCreate(savedInstanceState);
        mapView.onResume();
        mapView.getMapAsync(this);

        return view;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        googleMap.getUiSettings().setZoomControlsEnabled(true);
        googleMap.setTrafficEnabled(true);

        SharedPreferences prefs = this.getActivity().getSharedPreferences("PREFERENCIAS", Context.MODE_PRIVATE);
        String sede = prefs.getString("sede", "");
        String coordenada_x = prefs.getString("coordenadax", "");
        String coordenada_y = prefs.getString("coordenaday", "");

        Log.i("coordenada_x", "De: " + Double.valueOf(coordenada_x).toString());
        Log.i("coordenada_y", "De: " + Double.valueOf(coordenada_y).toString());

        googleMap.addMarker(new MarkerOptions()
                .position(new LatLng(Double.valueOf(coordenada_x),Double.valueOf( coordenada_y)))
                .title(sede)
                .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN)));

        googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(Double.valueOf(coordenada_x),Double.valueOf( coordenada_y)), 15));

    }
}
