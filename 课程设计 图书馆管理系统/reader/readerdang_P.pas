unit readerdang_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, ADODB, Mask, DBCtrls,
  Buttons,jpeg;

type
  Treaderdang = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Label15: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    ADOQuery2: TADOQuery;
    Label16: TLabel;
    Image1: TImage;
    ADOQuery3: TADOQuery;
    Label17: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  readerdang: Treaderdang;

implementation
uses unit1,readeradd_P,readerxiu_P;
{$R *.dfm}
//�˳�����//
procedure Treaderdang.BitBtn11Click(Sender: TObject);
begin
 close;
 unit1.Menu.show;
end;
//�����������//
procedure Treaderdang.BitBtn1Click(Sender: TObject);
begin
  edit2.clear;
 if (edit1.Text='') then
     begin
      application.MessageBox('��������߱��!','��ʾ',0+64);
    end
  else
     begin
     readerdang.ADOQuery1.Close;
      readerdang.ADOQuery1.SQL.Clear;
       readerdang.ADOQuery1.SQL.Add('select * from dbo.reader_type,dbo.reader '+'where r_id='+''''+edit1.Text+''' and dbo.reader.rt_no=dbo.reader_type.rt_no');
          readerdang.ADOQuery1.Open;
          if ADOQuery1.recordcount=0 then
          application.MessageBox('δ�ҵ��ö���!','��ʾ',0+64);
       label13.Caption:=inttostr(readerdang.ADOQuery1.RecordCount);
    end;
 end;

//����ƶ�//
procedure Treaderdang.BitBtn3Click(Sender: TObject);
begin
readerdang.adoquery1.First;
end;

procedure Treaderdang.BitBtn4Click(Sender: TObject);
begin
readerdang.adoquery1.Prior;
end;

procedure Treaderdang.BitBtn5Click(Sender: TObject);
begin
readerdang.adoquery1.Next;
end;

procedure Treaderdang.BitBtn6Click(Sender: TObject);
begin
readerdang.adoquery1.Last;
end;
//ɾ������//
procedure Treaderdang.BitBtn9Click(Sender: TObject);
begin
if adoquery1.recordcount=0 then
begin
application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
end
else
if (strtoint(dbedit10.Text)>0) then
begin
     application.MessageBox('�ö�����δ��ͼ��!','��ʾ',0+64);
     end
else
begin
if Application.MessageBox('ȷ��ɾ�������ͣ�','��ʾ',MB_YESNO)=IDYES then
   begin
      ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('delete from dbo.lend where r_id=:a');
      ADOQuery2.parameters.ParamByName('a').Value:=Trim(dbedit1.Text);
      ADOQuery2.SQL.Add('delete from dbo.reader where r_id=:b');
      ADOQuery2.parameters.ParamByName('b').Value:=Trim(dbEdit1.Text);
      ADOQuery2.ExecSQL;
      application.MessageBox('ɾ���ɹ�!','��ʾ',0+64);
      label13.Caption:=inttostr(readerdang.ADOQuery1.RecordCount);
   end;
   end;
end;
//ȫ����ʾ//
procedure Treaderdang.BitBtn10Click(Sender: TObject);
begin
     edit1.clear;
     edit2.clear;
    readerdang.ADOQuery1.Close;
      readerdang.ADOQuery1.SQL.Clear;
      readerdang.ADOQuery1.SQL.Add('select * from dbo.reader,dbo.reader_type where dbo.reader.rt_no=dbo.reader_type.rt_no');
      readerdang.ADOQuery1.Open;
      label13.Caption:=inttostr(readerdang.ADOQuery1.RecordCount);
      end;
procedure Treaderdang.BitBtn7Click(Sender: TObject);
begin
if readeradd= nil then
    readeradd:= Treaderadd.Create(Self);
    readeradd.ShowModal;
end;

procedure Treaderdang.BitBtn8Click(Sender: TObject);
begin
if adoquery1.recordcount=0 then
begin
application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
end
else
begin
if readerxiu= nil then
    readerxiu:= Treaderxiu.Create(Self);
    readerxiu.ShowModal;
end;
end;

procedure Treaderdang.BitBtn2Click(Sender: TObject);
begin
edit1.clear;
if (edit2.Text='') then
     begin
      application.MessageBox('�������������!','��ʾ',0+64);
    end
  else
     begin
     readerdang.ADOQuery1.Close;
      readerdang.ADOQuery1.SQL.Clear;
       readerdang.ADOQuery1.SQL.Add('select * from dbo.reader_type,dbo.reader '+'where r_name='+''''+edit2.Text+''' and dbo.reader.rt_no=dbo.reader_type.rt_no');
          readerdang.ADOQuery1.Open;
          if ADOQuery1.recordcount=0 then
          application.MessageBox('δ�ҵ��ö���!','��ʾ',0+64);
       label13.Caption:=inttostr(readerdang.ADOQuery1.RecordCount);
    end;
end;
//��ʾ��Ƭ

procedure Treaderdang.DBEdit1Change(Sender: TObject);
var
  Stream:TMemoryStream;
  bmp:TBitmap;
  jpg:TJpegImage; //jpgͼƬ��Ϣ
  Buffer:word;
begin
  if not ADOQuery1.FieldByName('r_p').IsNull then
  begin
  label17.Caption:='';
    Stream:=TMemoryStream.Create;
          jpg:=TJpegImage.Create;
          TBlobField(ADOQuery1.FieldByName('r_p')).SaveToStream(Stream);    // ��ʾ��ת��ΪBlobField�����浽�ڴ���
          Stream.Position :=0;
          if Stream.size=0 then
            begin
              label17.Caption:='   δ �� �� �� Ƭ';
            end
          else
            begin
              Stream.ReadBuffer(Buffer,2);
              if Buffer=$4D42 then
                begin
                  bmp:=TBitmap.create;
                  Stream.Position :=0;
                  bmp.LoadFromStream(Stream);    // ����ͼƬ
                  image1.Picture.Assign(bmp);
                end
              else if Buffer=$D8FF then
                begin
                  //showmessage('JPG');
                  jpg:=TJpegImage.Create;
                  Stream.Position :=0;
                  jpg.LoadFromStream(Stream);    // ����ͼƬ
                  image1.Picture.Assign(jpg);
                end;
            end;

  end
  else
  begin
  image1.Picture :=nil;
  label17.Caption:='   δ �� �� �� Ƭ';
  end;
end;

end.
