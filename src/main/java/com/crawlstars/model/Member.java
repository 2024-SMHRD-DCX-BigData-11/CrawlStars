package com.crawlstars.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class Member {
	@NonNull
	private String SP_name;
	@NonNull
	private String nick;
	private String gender;
	private String birthdate;
	//+프로필 이미지
	private String PL_link;
}
