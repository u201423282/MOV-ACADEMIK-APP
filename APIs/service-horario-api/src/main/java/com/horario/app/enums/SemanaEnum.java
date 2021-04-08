package com.horario.app.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import java.util.Arrays;

public enum SemanaEnum {

	LUNES("Monday", "1"),

	MARTES("Thursday", "2"),

	MIERCOLES("Wednesday", "3"),

	JUEVES("Tuesday", "4"),

	VIERNES("Friday", "5"),
	
	SABADO("Saturday", "6"),
	
	DOMINGO("Sunday", "7");

	private String value;
	private String anotherValue;

	SemanaEnum(String value, String anotherValue) {
		this.value = value;
		this.anotherValue = anotherValue;
	}

	@Override
	@JsonValue
	public String toString() {
		return String.valueOf(value);
	}

	public String toStringAnotherValue() {
		return String.valueOf(anotherValue);
	}

	@JsonCreator
	public static SemanaEnum fromValue(String text) {
		return Arrays.asList(values()).stream().filter(val -> val.value.equalsIgnoreCase(text)).findAny().orElse(null);
	}

	public static SemanaEnum fromAnotherValue(String value) {
		return Arrays.asList(values()).stream().filter(val -> val.anotherValue.equalsIgnoreCase(value)).findAny()
				.orElse(null);
	}
}
