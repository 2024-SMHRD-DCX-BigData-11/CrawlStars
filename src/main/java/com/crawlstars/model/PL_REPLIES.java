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
public class PL_REPLIES {
private int PL_REPLY_ID ;
@NonNull
private String PL_ID;
@NonNull
private String PL_REPLY_CONTENT;
@NonNull
private String REPLIED_AT;
@NonNull
private String SP_ID;
}
