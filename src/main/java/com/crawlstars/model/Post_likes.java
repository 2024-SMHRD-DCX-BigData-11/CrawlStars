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
@RequiredArgsConstructor
public class Post_likes {

	private int like_id;
	@NonNull
	private String sp_id;
	@NonNull
	private String post_id;
	private String created_at;
}
