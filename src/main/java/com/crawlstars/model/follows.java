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

public class follows {
	@NonNull
	private String follow_id;
	@NonNull
	private String follower;
	@NonNull
	private String followee;
	@NonNull
	private String flowered_at;
	
	public String getFollower() {
        return follower;
    }
	
	public String getFollowee() {
        return followee;
    }

	public follows(@NonNull String follower, @NonNull String followee) {
		super();
		this.follower = follower;
		this.followee = followee;
	}
	
	
}
