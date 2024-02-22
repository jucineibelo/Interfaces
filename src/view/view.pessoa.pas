unit view.pessoa;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  view.padrao,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.WinXPanels,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  pessoa;

type
  TfrmCadastroPessoa = class(TfrmPadrao)
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblDataCadastro: TLabel;
    lblTelefone: TLabel;
    lblEndereco: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtDataCadastro: TEdit;
    edtTelefone: TEdit;
    edtEndereco: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbgrdPesquisaCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    FPessoa : IPessoa;
    procedure ClearEdts;
  public
    { Public declarations }
  end;

var
  frmCadastroPessoa: TfrmCadastroPessoa;

implementation

uses
  dm.connection;

{$R *.dfm}

procedure TfrmCadastroPessoa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ClearEdts;
end;

procedure TfrmCadastroPessoa.btnExcluirClick(Sender: TObject);
begin
  inherited;
  FPessoa.Delete(dsPadrao.DataSet.FieldByName('id').AsInteger);
  FPessoa.Load;
end;

procedure TfrmCadastroPessoa.btnNovoClick(Sender: TObject);
begin
  inherited;
  ClearEdts;
  edtDataCadastro.Text := DateToStr(now);
end;

procedure TfrmCadastroPessoa.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  FPessoa.Find(edtPesquisa.Text);
end;

procedure TfrmCadastroPessoa.btnSalvarClick(Sender: TObject);
begin
  FPessoa.SetNome(edtNome.Text)
         .SetDataCadastro(StrToDate(edtDataCadastro.Text))
         .SetTelefone(edtTelefone.Text)
         .SetEndereco(edtEndereco.Text);

  case Trim(edtCodigo.Text) = EmptyStr  of   
    True : FPessoa.Insert; 
    False: FPessoa.Update(StrToInt(edtCodigo.Text)); 
  end;

  ClearEdts;
  FPessoa.Load;
  inherited;
end;


procedure TfrmCadastroPessoa.ClearEdts;
begin
  edtCodigo.Clear;
  edtNome.Clear;
  edtDataCadastro.Clear;
  edtTelefone.Clear;
  edtEndereco.Clear;  
end;

procedure TfrmCadastroPessoa.dbgrdPesquisaCellClick(Column: TColumn);
begin
  inherited;
  edtCodigo.Text       := dsPadrao.DataSet.FieldByName('id').AsString;
  edtNome.Text         := dsPadrao.DataSet.FieldByName('nome').AsString;
  edtDataCadastro.Text := dsPadrao.DataSet.FieldByName('datacadastro').AsString;
  edtTelefone.Text     := dsPadrao.DataSet.FieldByName('telefone').AsString;
  edtEndereco.Text     := dsPadrao.DataSet.FieldByName('endereco').AsString;
end;

procedure TfrmCadastroPessoa.edtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    btnPesquisaClick(Sender);
  end;
end;

procedure TfrmCadastroPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  FPessoa := TPessoa.New;
  FPessoa.Load;
end;

end.
