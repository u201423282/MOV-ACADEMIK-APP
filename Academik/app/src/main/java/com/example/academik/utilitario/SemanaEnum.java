package com.example.academik.utilitario;

import java.util.Arrays;

public enum SemanaEnum {

    LUNES("MONDAY", "1"),

    MARTES("THURSDAY", "2"),

    MIERCOLES("WEDNESDAY", "3"),

    JUEVES("TUESDAY", "4"),

    VIERNES("FRIDAY", "5"),

    SABADO("SATURDAY", "6"),

    DOMINGO("SUNDAY", "7");

    private String value;
    private String anotherValue;

    SemanaEnum(String value, String anotherValue) {
        this.value = value;
        this.anotherValue = anotherValue;
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }

    public String toStringAnotherValue() {
        return String.valueOf(anotherValue);
    }

    public static SemanaEnum fromValue(String text) {
        return Arrays.asList(values()).stream().filter(val -> val.value.equalsIgnoreCase(text)).findAny().orElse(null);
    }

    public static SemanaEnum fromAnotherValue(String value) {
        return Arrays.asList(values()).stream().filter(val -> val.anotherValue.equalsIgnoreCase(value)).findAny()
                .orElse(null);
    }
}
