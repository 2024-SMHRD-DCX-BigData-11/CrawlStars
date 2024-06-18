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
public class PL_REPLY_HASHTAGS {
	private String PL_REPLY_HASHTAG_ID;
	@NonNull
	private String PL_REPLY_ID;
	@NonNull
	private String HASHTAG;
}
