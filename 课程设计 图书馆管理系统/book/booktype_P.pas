unit booktype_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, Mask,
  DBCtrls;

type
  Tbooktype = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    ADOQuery2: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  booktype: Tbooktype;

implementation
uses unit1,booktypeadd_P,booktypexiu_P;
{$R *.dfm}

//��ѯ����//
procedure Tbooktype.BitBtn1Click(Sender: TObject);
begin
 if (edit5.Text='') then
     begin
      booktype.ADOQuery1.Close;
      booktype.ADOQuery1.SQL.Clear;
      booktype.ADOQuery1.SQL.Add('select * from dbo.book_type');
      booktype.ADOQuery1.Open;
      label6.Caption:=inttostr(booktype.ADOQuery1.RecordCount);
    end
  else
     begin
     booktype.ADOQuery1.Close;
      booktype.ADOQuery1.SQL.Clear;
       booktype.ADOQuery1.SQL.Add('select * from dbo.book_type '+
                                                        'where bt_no='+''''+edit5.Text+'''');
          booktype.ADOQuery1.Open;
          if(ADOquery1.Recordcount=0) then
          application.MessageBox('δ�ҵ������ͣ�','��ʾ',0+64);
       label6.Caption:=inttostr(booktype.ADOQuery1.RecordCount);
    end;
 end;

//����ƶ�//
procedure Tbooktype.BitBtn2Click(Sender: TObject);
begin
booktype.adoquery1.First;
end;

procedure Tbooktype.BitBtn3Click(Sender: TObject);
begin
booktype.adoquery1.Prior;
end;

procedure Tbooktype.BitBtn4Click(Sender: TObject);
begin
booktype.adoquery1.Next;
end;

procedure Tbooktype.BitBtn5Click(Sender: TObject);
begin
booktype.adoquery1.Last;
end;
//��Ӱ���//
procedure Tbooktype.BitBtn6Click(Sender: TObject);
begin
if booktypeadd= nil then
    booktypeadd:= Tbooktypeadd.Create(Self);
    booktypeadd.ShowModal;
end;
//�޸İ���//
procedure Tbooktype.BitBtn7Click(Sender: TObject);
begin
if adoquery1.recordcount=0 then
begin
application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
end
else
begin
if booktypexiu= nil then
    booktypexiu:= Tbooktypexiu.Create(Self);
    booktypexiu.ShowModal;
    end;
end;
//ɾ������//
procedure Tbooktype.BitBtn8Click(Sender: TObject);
begin
if adoquery1.recordcount=0 then
begin
application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
end
else
begin
ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('select * from dbo.book where bt_no=:a');
      ADOQuery2.parameters.ParamByName('a').Value:=Trim(dbedit1.Text);
      ADOQuery2.Open;
      if ADOQuery2.eof=false then
     begin
     application.MessageBox('���ڸ����͵�ͼ��!','��ʾ',0+64);
     end
     else
begin
if Application.MessageBox('ȷ��ɾ�������ͣ�','��ʾ',MB_YESNO)=IDYES then
   begin
     ADOQuery1.Delete;//ɾ����ǰ��
     ADOQuery1.UpdateBatch;
     application.Messagebox('ɾ���ɹ�!','��ʾ',0+64);
      label6.Caption:=inttostr(booktype.ADOQuery1.RecordCount);
   end;
   end;
   end;
end;

 //���ذ���//
procedure Tbooktype.BitBtn9Click(Sender: TObject);
begin
 close;
 unit1.Menu.show;
end;

end.
