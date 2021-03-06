unit readertypeadd_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB;

type
  Treadertypeadd = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    Label7: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edit2KeyPress(Sender: TObject; var Key: Char);
    procedure edit3KeyPress(Sender: TObject; var Key: Char);
    procedure edit4KeyPress(Sender: TObject; var Key: Char);
    procedure edit5KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  readertypeadd: Treadertypeadd;

implementation
 uses readertype_P;
{$R *.dfm}
//退出按键//
procedure Treadertypeadd.BitBtn2Click(Sender: TObject);
begin
close;
end;
//添加按键//
procedure Treadertypeadd.BitBtn1Click(Sender: TObject);
begin
 with ADOQuery1 do
   begin
      close;
      SQL.Clear;
      SQL.Add('select * from dbo.读者类型 where 读者类型编号=:b');
      parameters.ParamByName('b').Value:=Trim(Edit5.Text);
      Open;
   end;
  if (edit1.Text='')or(edit2.Text='') or(edit3.Text='')or(edit4.Text='')or(edit5.Text='') then
begin
application.MessageBox('信息不完整！','错误操作',mb_ok);
exit;
end
else if(length(edit5.Text)>3) then
     begin
     application.MessageBox('编号超过3位!','提示',0+64);
     Edit5.Clear;
     end
else if ADOQuery1.Eof=false then
   begin
     ShowMessage('该编号已存在，请重新填写');
     Edit1.Clear;
     Edit2.Clear;
     Edit3.Clear;
     Edit4.Clear;
     Edit5.Clear;
   end
else
begin
 adoquery1.close;
adoquery1.sql.clear;
Adoquery1.sql.add('insert into dbo.读者类型(读者类型编号,读者类型名称,最大借阅数量,最长借阅时间,最大续借次数)'
+'values (:1,:2,:3,:4,:5)');
Adoquery1.parameters.parambyname('1').value:=''+Edit5.Text+'';
Adoquery1.parameters.parambyname('2').value:=''+Edit1.Text+'';
Adoquery1.parameters.parambyname('3').value:=''+Edit2.Text+'';
Adoquery1.parameters.parambyname('4').value:=''+Edit3.Text+'';
Adoquery1.parameters.parambyname('5').value:=''+Edit4.Text+'';
Adoquery1.execsql;
if (adoquery1.rowsaffected>=1) then
    application.messagebox('添加成功!','提示',0+64);
     Edit1.Clear;
     Edit2.Clear;
     Edit3.Clear;
     Edit4.Clear;
     Edit5.Clear;
end;
end;

procedure Treadertypeadd.edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9'])  then
 begin
   application.MessageBox('请输入数字！', '提示',0+64);
   key:=#0;
   edit2.Text:='';
   end;
end;
procedure Treadertypeadd.edit3KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9'])  then
 begin
  application.MessageBox('请输入数字！', '提示',0+64);
   key:=#0;
   edit3.Text:='';
   end;
end;

procedure Treadertypeadd.edit4KeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (key in ['0'..'9'])  then
 begin
   application.MessageBox('请输入数字！', '提示',0+64);
   key:=#0;
   edit4.Text:='';
   end;
end;
procedure Treadertypeadd.edit5KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9'])  then
 begin
  application.MessageBox('请输入数字！', '提示',0+64);
   key:=#0;
   edit5.Text:='';
   end;
end;

end.
