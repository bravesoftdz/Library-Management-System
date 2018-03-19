unit admainset_P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, Mask,
  DBCtrls;

type
  Tadmainset = class(TForm)
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
    ADOQuery2: TADOQuery;
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  admainset: Tadmainset;

implementation
uses unit1,admainadd_P,admainxiu_P;
{$R *.dfm}
//���ذ���//
procedure Tadmainset.BitBtn9Click(Sender: TObject);
begin
 admainset_P.admainset.close;
 unit1.Menu.show;
end;
//��ѯ����//
procedure Tadmainset.BitBtn1Click(Sender: TObject);
begin
 if (edit5.Text='') then
     begin
      admainset.ADOQuery1.Close;
      admainset.ADOQuery1.SQL.Clear;
      admainset.ADOQuery1.SQL.Add('select * from dbo.admain');
      admainset.ADOQuery1.Open;
      label6.Caption:=inttostr(admainset.ADOQuery1.RecordCount);
    end
  else
     begin
     admainset.ADOQuery1.Close;
      admainset.ADOQuery1.SQL.Clear;
       admainset.ADOQuery1.SQL.Add('select * from dbo.admain '+
                                                        'where a_id='+''''+edit5.Text+'''');
          admainset.ADOQuery1.Open;
       label6.Caption:=inttostr(admainset.ADOQuery1.RecordCount);
    end;
    if ADOQuery1.recordcount=0 then
    application.Messagebox('δ�ҵ��ò���Ա!','��ʾ',0+64);
 end;

//����ƶ�//
procedure Tadmainset.BitBtn2Click(Sender: TObject);
begin
admainset.adoquery1.First;
end;

procedure Tadmainset.BitBtn3Click(Sender: TObject);
begin
admainset.adoquery1.Prior;
end;

procedure Tadmainset.BitBtn4Click(Sender: TObject);
begin
admainset.adoquery1.Next;
end;

procedure Tadmainset.BitBtn5Click(Sender: TObject);
begin
admainset.adoquery1.Last;
end;
//ɾ������//
procedure Tadmainset.BitBtn8Click(Sender: TObject);
begin
if ADOQuery1.recordcount=0 then
begin
    application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
    end
    else
    begin
    ADOQuery2.Close;
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('select * from dbo.lend where a_id=:a');
      ADOQuery2.parameters.ParamByName('a').Value:=Trim(dbedit1.Text);
      ADOQuery2.Open;
      if ADOQuery2.eof=false then
     begin
     application.MessageBox('���ڸò���Ա��Ϣ!','��ʾ',0+64);
     end
    else if Application.MessageBox('ȷ��ɾ�������ͣ�','��ʾ',MB_YESNO)=IDYES then
   begin
     ADOQuery1.Delete;//ɾ����ǰ��
     ADOQuery1.UpdateBatch;
      label6.Caption:=inttostr(admainset.ADOQuery1.RecordCount);
      application.MessageBox('ɾ���ɹ�!','��ʾ',0+64);
   end;
   end;
end;

procedure Tadmainset.BitBtn6Click(Sender: TObject);
begin
if admainadd= nil then
    admainadd:= Tadmainadd.Create(Self);
    admainadd.ShowModal;
end;

procedure Tadmainset.BitBtn7Click(Sender: TObject);
begin
if ADOQuery1.recordcount=0 then
begin
    application.Messagebox('�б�Ϊ��!','��ʾ',0+64);
    end
    else
    begin
if admainxiu= nil then
    admainxiu:= Tadmainxiu.Create(Self);
    admainxiu.ShowModal;
    end;
end;

end.
