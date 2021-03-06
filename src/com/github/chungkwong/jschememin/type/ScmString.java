/*
 * Copyright (C) 2016 Chan Chung Kwong
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 */
package com.github.chungkwong.jschememin.type;
import com.github.chungkwong.jschememin.*;
import java.nio.*;
import java.nio.charset.*;
import java.util.*;
public final class ScmString extends ScmObject implements Token,Comparable<ScmString>{
	private String val;
	public ScmString(String val){
		this.val=val;
	}
	public static String toFoldingCase(String str){
		return str.codePoints().map((c)->ScmCharacter.toFoldCase(c)).collect(StringBuilder::new,
			StringBuilder::appendCodePoint,StringBuilder::append).toString();
	}
	public static String toUpperCase(String str){
		return str.codePoints().map((c)->Character.toUpperCase(c)).collect(StringBuilder::new,
			StringBuilder::appendCodePoint,StringBuilder::append).toString();
	}
	public static String toLowerCase(String str){
		return str.codePoints().map((c)->Character.toLowerCase(c)).collect(StringBuilder::new,
			StringBuilder::appendCodePoint,StringBuilder::append).toString();
	}
	public ScmString toFoldingCase(){
		return new ScmString(toFoldingCase(val));
	}
	public ScmString toUpperCase(){
		return new ScmString(toUpperCase(val));
	}
	public ScmString toLowerCase(){
		return new ScmString(toLowerCase(val));
	}
	public static ScmString fill(ScmCharacter ch,int k){
		StringBuilder buf=new StringBuilder(k);
		int c=ch.getCodePoint();
		while(--k>=0)
			buf.appendCodePoint(c);
		return new ScmString(buf.toString());
	}
	public static ScmString toScmString(ScmPairOrNil list){
		return new ScmString(ScmList.asStream(list).mapToInt((c)->((ScmCharacter)c).getCodePoint())
				.collect(StringBuilder::new,StringBuilder::appendCodePoint,StringBuilder::append).toString());
	}
	public int length(){
		return val.codePointCount(0,val.length());
	}
	public ScmCharacter get(int index){
		return new ScmCharacter(val.codePointAt(val.offsetByCodePoints(0,index)));
	}
	public ScmString set(int index,ScmCharacter c){
		return setRange(c,index,index+1);
	}
	public ScmString setRange(ScmCharacter c,int start,int end){
		int size=end-start;
		start=val.offsetByCodePoints(0,start);
		end=val.offsetByCodePoints(start,size);
		StringBuilder buf=new StringBuilder(val.length());
		buf.append(val.substring(0,start));
		while(--size>=0)
			buf.appendCodePoint(c.getCodePoint());
		buf.append(val.substring(end));
		val=buf.toString();
		return this;
	}
	public ScmString substring(int start,int end){
		return copy(start,end);
	}
	public static ScmString append(ScmPairOrNil list){
		return new ScmString(ScmList.asStream(list).map((str)->((ScmString)str).getValue())
				.collect(StringBuilder::new,StringBuilder::append,StringBuilder::append).toString());
	}
	public ScmString copy(int start,int end){
		return new ScmString(val.substring(val.offsetByCodePoints(0,start),val.offsetByCodePoints(0,end)));
	}
	public ScmString copyTo(ScmString to,int at,int start,int end){
		at=to.val.offsetByCodePoints(0,at);
		int afterAt=to.val.offsetByCodePoints(at,end-start);
		start=val.offsetByCodePoints(0,start);
		end=val.offsetByCodePoints(0,end);
		StringBuilder buf=new StringBuilder();
		buf.append(to.val.substring(0,at));
		buf.append(val.substring(start,end));
		buf.append(to.val.substring(afterAt));
		to.val=buf.toString();
		return to;
	}
	public ScmPairOrNil toList(int start,int end){
		return ScmList.toList(substring(start,end).val.codePoints().mapToObj((c)->new ScmCharacter(c)).toArray((len)->new ScmCharacter[len]));
	}
	public String getValue(){
		return val;
	}
	@Override
	public boolean equals(Object obj){
		return obj instanceof ScmString&&((ScmString)obj).val.equals(val);
	}
	@Override
	public boolean equalsValue(ScmObject obj){
		return this==obj;
	}
	@Override
	public int hashCode(){
		int hash=3;
		hash=67*hash+Objects.hashCode(this.val);
		return hash;
	}
	@Override
	public String toExternalRepresentation(){
		StringBuilder buf=new StringBuilder();
		buf.append("\"");
		val.codePoints().forEach((c)->{
			if(c=='\"'||c=='\\')
				buf.append('\\');
			buf.appendCodePoint(c);
		});
		buf.append("\"");
		return buf.toString();
	}
	@Override
	public boolean isSelfevaluating(){
		return true;
	}
	@Override
	public int compareTo(ScmString o){
		return val.compareTo(o.val);
	}
	public int compareToIgnoreCase(ScmString o){
		return val.compareToIgnoreCase(o.val);
	}
	public ScmByteVector toScmByteVector(int start,int end){
		start=val.offsetByCodePoints(0,start);
		end=val.offsetByCodePoints(0,end);
		ByteBuffer buf=StandardCharsets.UTF_8.encode(val.substring(start,end));
		return new ScmByteVector(Arrays.copyOf(buf.array(),buf.limit()));
	}
	public ScmVector toScmVector(int start,int end){
		ArrayList<ScmObject> vector=new ArrayList<>(end-start);
		int offset=val.offsetByCodePoints(0,start);
		while(++start<=end){
			vector.add(new ScmCharacter(val.codePointAt(offset)));
			offset=val.offsetByCodePoints(offset,1);
		}
		return new ScmVector(vector);
	}
}