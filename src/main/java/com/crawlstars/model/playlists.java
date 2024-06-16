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
public class playlists {
	@NonNull
	private String pl_id;
	@NonNull
	private String pl_title;
	@NonNull
	private String sp_id;
	@NonNull
	private String status;
	private String pl_image;
	private String created_at;
	private String updated_at;
}
