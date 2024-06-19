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
	private String SP_id;
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
	private String user_img;
	@NonNull
	private String uesr_type;
	
	public users(@NonNull String sP_id, @NonNull String nick, @NonNull String gender, @NonNull String birthdate,
			@NonNull String user_img, @NonNull String uesr_type) {
		super();
		SP_id = sP_id;
		this.nick = nick;
		this.gender = gender;
		this.birthdate = birthdate;
		this.user_img = user_img;
		this.uesr_type = uesr_type;
	}
	
	
	
	
}
