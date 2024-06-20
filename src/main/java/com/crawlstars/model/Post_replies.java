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
public class Post_replies {
private int post_reply_id;
@NonNull
private String post_id;
@NonNull
private String reply_content;
private String replied_at;
@NonNull
private String sp_id;
private String nick;
private String hashtag;
}
