unit guihuan_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, Mask,
  DBCtrls,DateUtils;

type
  Tguihuan = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    DBGrid1: TDBGrid;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBGrid2: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Label9: TLabel;
    Label10: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    ADOQuery4: TADOQuery;
    ADOQuery5: TADOQuery;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    BitBtn2: TBitBtn;
    Label11: TLabel;
    Label12: TLabel;
    Timer1: TTimer;
    procedure Formshow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  guihuan: Tguihuan;
  tt:integer;
implementation
 uses unit1,chaoqifakuan_P,main;
{$R *.dfm}
var
   bookcount:integer;
procedure Tguihuan.Formshow(Sender: TObject);
begin
  Label10.Caption:='0';
  label8.Caption:='0';
  edit1.text:='';
  edit5.text:='';
  ADOQuery1.Close;
  ADOQuery3.Close;
  ADOQuery4.Close;
  ADOQuery5.Close;
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('delete from dbo.exceed');
  ADOQuery2.ExecSQL;
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('delete from dbo.book_id');
  ADOQuery2.ExecSQL;
  end;
procedure Tguihuan.BitBtn3Click(Sender: TObject);
begin
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('delete from dbo.book_id ');
  ADOQuery2.ExecSQL;
  close;
  unit1.Menu.show;
end;

//��ʾ���߼��ѽ���Ϣ
procedure Tguihuan.BitBtn4Click(Sender: TObject);
var
  I:integer;
  j:integer;
  k:integer;
  temp1:string;
  temp2:string;
  temp3:string;
  temp4:string;
  time1:TDatetime;
  time2:TDatetime;
  time3:TDatetime;
  today:TDatetime;
begin
  if (edit1.Text='') then
     begin
       application.MessageBox('��������߱��!','��ʾ',0+64);
         exit;
    end
  else
     begin
      //ɾ�����ڱ�
      ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('delete from dbo.exceed');
      ADOQuery2.ExecSQL;
      //��ʾ������Ϣ
      ADOQuery1.Close;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('select * from dbo.reader,dbo.reader_type where (dbo.reader.r_id=:a) and (dbo.reader.rt_no=dbo.reader_type.rt_no)');
      ADOQuery1.parameters.ParamByName('a').Value:=Trim(edit1.Text);
      ADOQuery1.Open;
      if ADOQuery1.recordcount=0 then
      application.Messagebox('δ�ҵ��ö���!','��ʾ',0+64);

      //��ʾ�ѽ���Ϣ
      ADOQuery5.Close;
      ADOQuery5.SQL.Clear;
      ADOQuery5.SQL.Add('select * from dbo.book,dbo.lend where (dbo.lend.r_id=:a) and (dbo.book.b_id=dbo.lend.b_id)  and (dbo.lend.l_no not in (select l_no from r_book))');
      ADOQuery5.parameters.ParamByName('a').Value:=Trim(edit1.Text);
      ADOQuery5.Open;
      j:=ADOQuery5.RecordCount;      //DBGrid1��¼��
      if ADOQuery5.recordcount=0 then
       application.Messagebox('δ���ڸö��߽�����Ϣ!','��ʾ',0+64);
       label10.caption:=inttostr(ADOQuery5.recordcount);

      //showmessage('j'+inttostr(j));
      //���㳬������
      for I:=1 to j do
        begin
          ADOQuery5.RecNo:=I;
          temp1:=DBGrid1.Fields[6].DisplayText;    //��ȡ�黹����
          temp4:=DBGrid1.Fields[0].DisplayText;     //���ı��
          //showmessage(temp4);
          time1:=strtodatetime(temp1);
          temp1:=formatDatetime('YYYYMMDD',time1);
          temp2:=formatDatetime('YYYYMMDD',now);
          if strtoint(temp2)<=strtoint(temp1) then
            k:=0
          else
            k:=Daysbetween(now,time1);
          temp3:=inttostr(k);    //��������
          // showmessage(temp3);

          //���볬�ڱ�
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('insert into dbo.exceed(l_no,e_time) values(:1,:2)');
          ADOQuery2.parameters.ParamByName('1').Value:=trim(temp4);
          ADOQuery2.Parameters.ParamByName('2').Value:=strtoint(temp3);
          ADOQuery2.ExecSQL;
          //showmessage('ok'+inttostr(i));
        end;
     end;
  //��ʾ�ѽ���Ϣ
  ADOQuery5.Close;
  ADOQuery5.SQL.Clear;
  ADOQuery5.SQL.Add('select * from dbo.book,dbo.lend,dbo.exceed where (dbo.lend.r_id=:a) and (dbo.book.b_id=dbo.lend.b_id)  and (dbo.lend.l_no=dbo.exceed.l_no) and (dbo.lend.l_no not in (select l_no from r_book))');
  ADOQuery5.parameters.ParamByName('a').Value:=Trim(edit1.Text);
  ADOQuery5.Open;
  bookcount:=ADOQuery5.RecordCount;    //DBGrid1��¼��
  Label10.Caption:=inttostr(ADOQuery5.RecordCount);
end;

//��ʾҪ�黹ͼ����Ϣ
procedure Tguihuan.BitBtn5Click(Sender: TObject);
var
  I:integer;
  j:integer;
  count:integer;
  temp1:string;
begin
  count:=0;
  if (edit5.Text='') then
     begin
      application.MessageBox('������ͼ����!','��ʾ',0+64);
         exit;
     end
  else
    begin
      //j:=DBGrid1.FieldCount;
      j:=bookcount;      //DBGrid1��¼��
      //showmessage(inttostr(j));

      //�ж��Ƿ��н��ͼ��
      for I:=1 to j do
      begin
        //showmessage(inttostr(i)+edit5.text);
        ADOQuery5.RecNo:=I;
        temp1:=DBGrid1.Fields[1].DisplayText;
        if temp1=edit5.text then
          break;
      end;
      if i>j then
        begin
          //showmessage(inttostr(i)+inttostr(j));
         application.MessageBox('�޸�ͼ�������Ϣ!','��ʾ',0+64);
          edit5.Text:='';
        end
      else
        begin
          ADOQuery4.Close;
          ADOQuery4.SQL.Clear;
          //ADOQuery4.SQL.Add('delete * from dbo.book_id');
          ADOQuery4.SQL.Add('select * from dbo.book_id where b_id=:a');
          ADOQuery4.Parameters.ParamByName('a').Value:=''+edit5.Text+'';
          ADOQuery4.Open;
          if ADOQuery4.RecordCount>0 then
            begin
              application.MessageBox('�����Ѵ���!','��ʾ',0+64);
              edit5.Text:='';
            end
          else
            begin
              ADOQuery4.Close;
              ADOQuery4.SQL.Clear;
              Adoquery4.sql.add('insert into dbo.book_id(b_id)'+'values (:1)');
              Adoquery4.parameters.parambyname('1').value:=''+Edit5.Text+'';
              ADOQuery4.ExecSQL;
            end;
          //��ʾҪ�黹ͼ��
          ADOQuery3.Close;
          ADOQuery3.SQL.Clear;
          ADOQuery3.SQL.Add('select * from dbo.book,dbo.lend,dbo.reader,dbo.exceed,dbo.book_id where (dbo.book.b_id=dbo.book_id.b_id) and (dbo.lend.r_id=dbo.reader.r_id) and (dbo.book.b_id=dbo.lend.b_id) and  (dbo.lend.l_no=dbo.exceed.l_no)');
          ADOQuery3.Open;
          tt:=ADOQuery3.recordcount;
          label8.caption:=inttostr(tt);
        end;
    end;
end;

//�黹ͼ��
procedure Tguihuan.BitBtn1Click(Sender: TObject);
var
  I:integer;
  j:integer;
  fkcount:integer;
  cqcount:integer;
  rbcount:integer;
  today:string;
  temp1:string;
  temp2:string;
  temp3:string;
  temp4:string;
  temp5:string;
  temp6:string;
  temp7:integer;
  temp8:integer;
begin
if DBedit1.Text='' then
    begin
      application.MessageBox('�����뻹�����!','��ʾ',0+64);
      exit;
    end;
  //�ж��Ƿ���ڹ黹��ͼ��
  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('select * from dbo.book_id');
  ADOQuery2.Open;
  j:=ADOQuery2.RecordCount;             //��黹ͼ����
  if ADOQuery2.RecordCount=0 then
    begin
      application.MessageBox('û����Ҫ�黹��ͼ��!','��ʾ',0+64);
    end
  else
    begin
      today:=FormatDatetime('YYYYMMDD',now);     //��ȡ���ڵ�ʱ��
      //ͳ���ѷ�����
      ADOQuery4.Close;
      ADOQuery4.SQL.Clear;
      ADOQuery4.SQL.Add('select*from dbo.forfeit where f_no like :a');
      ADOQuery4.Parameters.ParamByName('a').Value:=trim(today+'%');
      ADOQuery4.Open;
      fkcount:=adoquery4.recordcount;      //�ѷ�����

      //ͳ���Ѵ�����
      ADOQuery4.Close;
      ADOQuery4.SQL.Clear;
      ADOQuery4.SQL.Add('select*from dbo.r_book where r_no like :a');
      ADOQuery4.Parameters.ParamByName('a').Value:=trim(today+'%');
      ADOQuery4.Open;
      rbcount:=adoquery4.recordcount;      //�Ѵ�����

      //showmessage('ok');
      for I:=1 to j do
        begin
          ADOQuery3.RecNo:=I;
          temp1:=DBGrid2.Fields[8].DisplayText;   //����ʱ��
          temp3:=DBGrid2.Fields[0].DisplayText;   //���ı��
          temp4:=DBGrid2.Fields[1].DisplayText;   //ͼ����
          if strtoint(temp1)>0 then
            begin
              //����forfeit
              temp2:=format('%.4d',[fkcount+i]);     //������
              //showmessage(temp2);
              cqcount:=1;
              //showmessage('hukiang');
              //���·����
              ADOQuery4.Close;
              ADOQuery4.SQL.Clear;
              ADOQuery4.SQL.Add('insert into dbo.forfeit values(:1,:2,:3,:4,:5,:6,:7,:8)');
              ADOQuery4.Parameters.ParamByName('1').Value:=Trim(FormatDatetime('YYYYMMDD',now)+temp2);
              ADOQuery4.Parameters.ParamByName('2').Value:=Trim(Edit1.Text);
              ADOQuery4.Parameters.ParamByName('3').Value:=Trim(temp4);
              ADOQuery4.Parameters.ParamByName('4').Value:=strtoint(temp1);
              ADOQuery4.Parameters.ParamByName('5').Value:=Trim(FormatDatetime('YYYY-MM-DD HH:NN:SS',now));
              ADOQuery4.Parameters.ParamByName('6').Value:=Trim('����');
              ADOQuery4.Parameters.ParamByName('7').Value:=Trim(main.frmMain.edit1.Text);
              ADOQuery4.Parameters.ParamByName('8').Value:=0;
              ADOQuery4.ExecSQL;
            end;

          //��������
          ADOQuery3.delete;
         // showmessage('delete');
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('delete from dbo.book_id where b_id=:a');
          ADOQuery2.Parameters.ParamByName('a').Value:=Trim(temp4);
          ADOQuery2.ExecSQL;
         // showmessage('Close');
          //���»����
          temp6:=format('%.4d',[rbcount+i]);
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('insert into dbo.r_book values(:a,:b,:c,:d)');
          ADOQuery2.Parameters.ParamByName('a').Value:=Trim(FormatDatetime('YYYYMMDD',now)+temp6);
          ADOQuery2.Parameters.ParamByName('b').Value:=Trim(temp3);
          ADOQuery2.Parameters.ParamByName('c').Value:=Trim(FormatDatetime('YYYY-MM-DD HH:NN:SS',now));
          ADOQuery2.Parameters.ParamByName('d').Value:=Trim(main.frmMain.edit1.Text);
          ADOQuery2.ExecSQL;
           //����book��
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('select * from dbo.book where b_id=:1');
          ADOQuery2.Parameters.ParamByName('1').Value:=Trim(temp4);
          ADOQuery2.Open;
          temp7:=adoquery2.fieldByName('remain_vol').asinteger;
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('update dbo.book set remain_vol=:1 where b_id=:2');
          ADOQuery2.Parameters.ParamByName('1').Value:=temp7+1;
          ADOQuery2.Parameters.ParamByName('2').Value:=Trim(temp4);
          ADOQuery2.ExecSQL;
          //����reader��
           ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('select * from dbo.reader where r_id=:1');
          ADOQuery2.Parameters.ParamByName('1').Value:=Trim(edit1.Text);
          ADOQuery2.Open;
          temp8:=adoquery2.fieldByName('bor_vol').asinteger;
          ADOQuery2.Close;
          ADOQuery2.SQL.Clear;
          ADOQuery2.SQL.Add('update dbo.reader set bor_vol=:1 where r_id=:2');
          ADOQuery2.Parameters.ParamByName('1').Value:=temp8-1;
          ADOQuery2.Parameters.ParamByName('2').Value:=Trim(edit1.Text);
          ADOQuery2.ExecSQL;
          //����DBGrid1
         ADOQuery5.Close;
         ADOQuery5.SQL.Clear;
         ADOQuery5.SQL.Add('select * from dbo.book,dbo.lend where (dbo.lend.r_id=:a) and (dbo.book.b_id=dbo.lend.b_id)  and (dbo.lend.l_no not in (select l_no from r_book))');
         ADOQuery5.parameters.ParamByName('a').Value:=Trim(edit1.Text);
         ADOQuery5.Open;
         Label10.Caption:=inttostr(ADOQuery5.RecordCount);
         // showmessage('ok');
        end;
        application.MessageBox('����ɹ�!','��ʾ',0+64);
        edit5.Clear;
        label8.caption:='0';
    end;
  if cqcount=1 then
    begin
      application.MessageBox('����Ҫ�����ͼ��!','��ʾ',0+64);
      //���볬�ڷ��
      guihuan_p.guihuan.hide;
      if chaoqifakuan= nil then
        chaoqifakuan:= Tchaoqifakuan.Create(Self);
      chaoqifakuan.ShowModal;
      cqcount:=0;
    end;
end;

procedure Tguihuan.BitBtn2Click(Sender: TObject);
var
  temp:string;
begin
if label8.Caption='0' then
begin
application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
end
else
begin
  temp:=DBGrid1.Fields[0].DisplayText;
  ADOQuery2.delete;
  ADOQuery3.Close;
  ADOQuery3.SQL.Clear;
  ADOQuery3.SQL.Add('delete from dbo.book_id where b_id=:a');
  ADOQuery3.Parameters.ParamByName('a').Value:=temp;
  ADOQuery3.ExecSQL;
  tt:=tt-1;
  label8.caption:=inttostr(tt);
  end;
end;

procedure Tguihuan.Timer1Timer(Sender: TObject);
begin
 label12.caption:=datetimetostr(now);
end;

end.
