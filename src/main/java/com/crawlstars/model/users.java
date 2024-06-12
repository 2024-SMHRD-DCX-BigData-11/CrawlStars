package com.crawlstars.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class users {
	@NonNull
	private String SP_name;
	@NonNull
	private String nick;
	@NonNull
	private String gender;
	@NonNull
	private String birthdate;
	//+프로필 이미지
	@NonNull
	private String joined_at;
	@NonNull
	private String uesr_type;
	
	public users(@NonNull String SP_name, @NonNull String nick, String gender, String birthdate, String uesr_type) {
		super();
		SP_name = SP_name;
		this.nick = nick;
		this.gender = gender;
		this.birthdate = birthdate;
		this.uesr_type = uesr_type;
	}
}
