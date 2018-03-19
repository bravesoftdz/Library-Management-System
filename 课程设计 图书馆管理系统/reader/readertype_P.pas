unit readertype_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, Mask,
  DBCtrls;

type
  Treadertype = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    ADOQuery2: TADOQuery;
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  readertype: Treadertype;

implementation
uses unit1,readertypeadd_P,readertypexiu_P;
{$R *.dfm}
//���ذ���//
procedure Treadertype.BitBtn9Click(Sender: TObject);
begin
 close;
 unit1.Menu.show;
end;
//��ѯ����//
procedure Treadertype.BitBtn1Click(Sender: TObject);
begin
 if (edit5.Text='') then
     begin
      readertype.ADOQuery1.Close;
      readertype.ADOQuery1.SQL.Clear;
      readertype.ADOQuery1.SQL.Add('select * from dbo.��������');
      readertype.ADOQuery1.Open;
      label6.Caption:=inttostr(readertype.ADOQuery1.RecordCount);
    end
  else
     begin
     readertype.ADOQuery1.Close;
      readertype.ADOQuery1.SQL.Clear;
       readertype.ADOQuery1.SQL.Add('select * from dbo.�������� '+
                                                        'where �������ͱ��='+''''+edit5.Text+'''');
          readertype.ADOQuery1.Open;
       label6.Caption:=inttostr(readertype.ADOQuery1.RecordCount);
    end;
    if ADOQuery1.recordcount=0 then
    application.Messagebox('δ�ҵ��ö�������!','��ʾ',0+64);
 end;
//��Ӱ���//
procedure Treadertype.BitBtn6Click(Sender: TObject);
begin
   if readertypeadd= nil then
    readertypeadd:= Treadertypeadd.Create(Self);
    readertypeadd.ShowModal;
end;
//�޸İ���//
procedure Treadertype.BitBtn7Click(Sender: TObject);
begin
if ADOQuery1.recordcount=0 then
begin
    application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
    end
    else
    begin
  if readertypexiu= nil then
    readertypexiu:= Treadertypexiu.Create(Self);
    readertypexiu.ShowModal;
    end;
end;
//����ƶ�//
procedure Treadertype.BitBtn2Click(Sender: TObject);
begin
readertype.adoquery1.First;
end;

procedure Treadertype.BitBtn3Click(Sender: TObject);
begin
readertype.adoquery1.Prior;
end;

procedure Treadertype.BitBtn4Click(Sender: TObject);
begin
readertype.adoquery1.Next;
end;

procedure Treadertype.BitBtn5Click(Sender: TObject);
begin
readertype.adoquery1.Last;
end;
//ɾ������//
procedure Treadertype.BitBtn8Click(Sender: TObject);
begin
if ADOQuery1.recordcount=0 then
begin
    application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
    end
    else
    begin
    ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('select * from dbo.������Ϣ where �������ͱ��=:a');
      ADOQuery2.parameters.ParamByName('a').Value:=Trim(dbedit1.Text);
      ADOQuery2.Open;
      if ADOQuery2.eof=false then
     begin
     application.MessageBox('���ڸ����͵Ķ���!','��ʾ',0+64);
     end
     else
     begin
if Application.MessageBox('ȷ��ɾ�������ͣ�','��ʾ',MB_YESNO)=IDYES then
   begin
     ADOQuery1.Delete;//ɾ����ǰ��
     ADOQuery1.UpdateBatch;
      application.Messagebox('ɾ���ɹ�!','��ʾ',0+64);
      label6.Caption:=inttostr(readertype.ADOQuery1.RecordCount);
   end;
   end;
   end;
end;

end.
