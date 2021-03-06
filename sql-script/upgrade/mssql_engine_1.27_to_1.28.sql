alter table ACT_HI_PROCVARIABLE
drop column EXECUTION_ID_;

alter table ACT_HI_PROCVARIABLE
drop column TASK_ID_;

alter table ACT_HI_PROCVARIABLE
drop column ACT_INST_ID_;

alter table ACT_HI_PROCVARIABLE
drop column ACT_INST_ID_;

alter table ACT_HI_PROCVARIABLE
drop column TIME_;

alter table ACT_RE_PROCDEF
    alter column KEY_ nvarchar(255) not null;

alter table ACT_RE_PROCDEF
    alter column VERSION_ int not null;
    
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PROCDEF 
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
	
insert into ACT_HI_PROCVARIABLE
  (ID_,PROC_INST_ID_,EXECUTION_ID_,TASK_ID_,ACT_INST_ID_,NAME_,VAR_TYPE_,REV_,TIME_,BYTEARRAY_ID_,DOUBLE_,LONG_,TEXT_,TEXT2_)
  select d.ID_,d.PROC_INST_ID_,d.EXECUTION_ID_,d.TASK_ID_,d.ACT_INST_ID_,d.NAME_,d.VAR_TYPE_,d.REV_,d.TIME_,d.BYTEARRAY_ID_,d.DOUBLE_,d.LONG_,d.TEXT_,d.TEXT2_
  from ACT_HI_DETAIL d
  inner join
    (
      select de.PROC_INST_ID_, de.NAME_, MAX(de.TIME_) as MAXTIME
      from ACT_HI_DETAIL de
      inner join ACT_HI_PROCINST p on de.PROC_INST_ID_ = p.ID_
      where p.END_TIME_ is not NULL
      group by de.PROC_INST_ID_, de.NAME_
    )
  groupeddetail on d.PROC_INST_ID_ = groupeddetail.PROC_INST_ID_
  and d.NAME_ = groupeddetail.NAME_
  and d.TIME_ = groupeddetail.MAXTIME
  and (select prop.VALUE_ from ACT_GE_PROPERTY prop where prop.NAME_ = 'historyLevel') = 3;

update ACT_GE_PROPERTY
  set VALUE_ = VALUE_ + 1,
      REV_ = REV_ + 1
  where NAME_ = 'historyLevel' and VALUE_ >= 2;
    
alter table ACT_HI_DETAIL
	alter column PROC_INST_ID_ nvarchar(64) null;

alter table ACT_HI_DETAIL
	alter column EXECUTION_ID_ nvarchar(64) null;

