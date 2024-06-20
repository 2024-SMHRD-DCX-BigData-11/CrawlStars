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
public class Post_reply_hashtags {
	private int hashtag_id ;
	@NonNull
	private int post_reply_id ;
	@NonNull
	private String hashtag ;
}
