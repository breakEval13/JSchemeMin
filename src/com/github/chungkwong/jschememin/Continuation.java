/*
 * Copyright (C) 2016 Chan Chung Kwong <1m02math@126.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.github.chungkwong.jschememin;
import com.github.chungkwong.jschememin.type.*;
import java.util.*;
/**
 *
 * @author Chan Chung Kwong <1m02math@126.com>
 */
public class Continuation extends ScmObject{
	private final Stack<Evaluable> actives;
	private final Stack<Object> pointers;
	private ScmObject arguments;
	public Continuation(){
		this.pointers=new Stack<>();
		this.actives=new Stack<>();
	}
	public Continuation(Stack<Evaluable> actives,Stack<Object> pointers){
		this.pointers=pointers;
		this.actives=actives;
	}
	public void callInit(Evaluable proc,ScmObject arguments){
		actives.push(proc);
		pointers.push(null);
		this.arguments=arguments;
	}
	public void call(Evaluable proc,Object pointer,ScmObject arguments){
		actives.push(proc);
		pointers.pop();
		pointers.push(pointer);
		pointers.push(null);
		this.arguments=arguments;
	}
	public void callTail(Evaluable proc,ScmObject arguments){
		actives.pop();
		pointers.pop();
		actives.push(proc);
		pointers.push(null);
		this.arguments=arguments;
	}
	public void replaceCurrent(Evaluable proc){
		actives.pop();
		actives.push(proc);
	}
	public void ret(ScmObject retValue){
		actives.pop();
		pointers.pop();
		this.arguments=retValue;
	}
	public void reset(Continuation cont){
		actives.clear();
		pointers.clear();
		actives.addAll(cont.actives);
		pointers.addAll(cont.pointers);
		arguments=cont.arguments;
	}
	public void evalNext(Environment env){
		actives.peek().call(env,this,pointers.peek(),arguments);
	}
	public boolean hasNext(){
		return !pointers.isEmpty();
	}
	public ScmObject getValue(){
		return arguments;
	}
	public Continuation getCopy(){
		return new Continuation((Stack)actives.clone(),(Stack)pointers.clone());
	}
	@Override
	public String toExternalRepresentation(){
		return actives.toString();
	}
	@Override
	public boolean isSelfevaluating(){
		return false;
	}
}