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

public class playlists {
	@NonNull
	private int pl_id;
	@NonNull
	private String song;
	@NonNull
	private String pl_title;
	@NonNull
	private String sp_id;
	@NonNull
	private String singer;
	@NonNull
	private String pl_image;
	@NonNull
	private String created_at;
	@NonNull
	private String updated_at;
}
