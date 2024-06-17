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
	private String status;
	@NonNull
	private String pl_image;
	private String created_at;
	private String updated_at;
	public playlists(@NonNull String pl_id, @NonNull String pl_title, @NonNull String sp_id, @NonNull String status,
			String pl_image) {
		super();
		this.pl_id = pl_id;
		this.pl_title = pl_title;
		this.sp_id = sp_id;
		this.status = status;
		this.pl_image = pl_image;
	}
}
