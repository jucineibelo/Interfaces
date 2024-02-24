unit view.padrao;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Data.DB,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.WinXPanels,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.ExprFuncs,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Phys;

type
  TfrmPadrao = class(TForm)
    pnlFundo: TPanel;
    CardPanel1: TCardPanel;
    viewDados: TCard;
    viewPesquisa: TCard;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlPesquisa: TPanel;
    edtPesquisa: TEdit;
    btnPesquisa: TSpeedButton;
    lblConsulta: TLabel;
    dbgrdPesquisa: TDBGrid;
    pnlBtns: TPanel;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnCancelar: TSpeedButton;
    pnlSuporte: TPanel;
    pnlFechar: TPanel;
    btnSair: TSpeedButton;
    pnl: TPanel;
    pnl1: TPanel;
    btnSair1: TSpeedButton;
    dsPadrao: TDataSource;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure ActiveButtons(AValue: Boolean);
    procedure FormCreate(Sender: TObject);
  private

  public
  end;

var
  frmPadrao: TfrmPadrao;

implementation

uses
  System.UITypes;

{$R *.dfm}

procedure TfrmPadrao.ActiveButtons(AValue: Boolean);
begin
  btnNovo.Enabled     := AValue;
  btnEditar.Enabled   := btnNovo.Enabled;
  btnSalvar.Enabled   := not btnNovo.Enabled;
  btnCancelar.Enabled := not btnNovo.Enabled;
  btnExcluir.Enabled  := btnNovo.Enabled;
end;

procedure TfrmPadrao.btnCancelarClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := viewPesquisa;
  ActiveButtons(True);
end;

procedure TfrmPadrao.btnEditarClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := viewDados;
  ActiveButtons(False);
end;

procedure TfrmPadrao.btnExcluirClick(Sender: TObject);
begin
  case MessageDlg('Deseja mesmo excluir esse registro?', mtConfirmation, [mbYes, mbNo], 0) = mrNo  of
    True:  Abort;
    False: MessageDlg('Registro excluido com sucesso!', mtInformation, [mbOK], 0);
  end;

  ActiveButtons(True);
end;

procedure TfrmPadrao.btnNovoClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := viewDados;
  ActiveButtons(False);
end;

procedure TfrmPadrao.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
begin
  CardPanel1.ActiveCard := viewPesquisa;
  ActiveButtons(True);
  MessageDlg('Registro salvo com sucesso!', mtInformation, [mbOK], 0);
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  CardPanel1.ActiveCard := viewPesquisa;
  ActiveButtons(True);
end;

end.

