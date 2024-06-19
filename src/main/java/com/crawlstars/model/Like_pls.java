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
public class Like_pls {
	private int like_id;
	@NonNull
	private String sp_id;
	@NonNull
	private String pl_id;
	private String liked_at;
	private String pl_img;
}
