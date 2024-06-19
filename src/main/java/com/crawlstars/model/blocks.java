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

public class blocks {
	@NonNull
	private String block_id;
	@NonNull
	private String sp_id;
	@NonNull
	private String block_sp_id;
	@NonNull
	private String blocked_at;
}
