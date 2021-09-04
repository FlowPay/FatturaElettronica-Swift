//
//  Created by Federico Giuntoli on 29/08/20.
//

import Foundation

// MARK: - Entità in comune

public struct Indirizzo: Codable {
    public let indirizzo: String
    public let numeroCivico: String?
    public let cap: Int
    public let comune: String
    public let provincia: String?
    public let nazione: String
    
    public init(indirizzo: String, numeroCivico: String?, cap: Int, comune: String, provincia: String?, nazione: String) {
        self.indirizzo = indirizzo
        self.numeroCivico = numeroCivico
        self.cap = cap
        self.comune = comune
        self.provincia = provincia
        self.nazione = nazione
    }

    enum CodingKeys: String, CodingKey{
        case indirizzo = "indirizzo"
        case numeroCivico =  "numerocivico"
        case cap = "cap"
        case comune = "comune"
        case provincia = "provincia"
        case nazione = "nazione"
    }
}

public struct Anagrafica: Codable {
    public let denominazione: String?
    public let nome: String?
    public let cognome: String?
    public let codEORI: String?
    public let titolo: String?
    
    public var anagrafica: String {
        if let value = self.denominazione{
            return value
        }
        return [self.nome, self.cognome].compactMap { $0 }.joined(separator: " ")
    }
    
    public init(denominazione: String?, nome: String?, cognome: String?, codEORI: String?, titolo: String?) {
        self.denominazione = denominazione
        self.nome = nome
        self.cognome = cognome
        self.codEORI = codEORI
        self.titolo = titolo
    }

    enum CodingKeys: String, CodingKey{
        case denominazione = "denominazione"
        case nome = "nome"
        case cognome = "cognome"
        case codEORI = "codeori"
        case titolo = "titolo"
    }
}

public struct IDFiscale: Codable {
    public let idPaese: String
    public let idCodice: String
    
    public init(idPaese: String, idCodice: String) {
        self.idPaese = idPaese
        self.idCodice = idCodice
    }

    enum CodingKeys: String, CodingKey{
        case idPaese = "idpaese"
        case idCodice = "idcodice"
    }
}

public enum Natura: String, Codable {
    case ESCLUSE = "N1"
   
    case NONSOGGETTEADIVA = "N2.1"
    case NONSOGGETTEALTRICASI = "N2.2"
    case NONIMPONIBILIESPORTAZIONI = "N3.1"
    case NONIMPONIBILICESSIONINTRACOMUNITARIE = "N3.2"
    case NONIMPONIBILIVERSOSANMARINO = "N3.3"
    case NONIMPONIBILIOPERAZIONIASSIMILATE = "N3.4"
    case NONIMPONIBILIASEGUITODIDICHIARAZIONI = "N3.5"
    case NONIMPONIBILIALTREOPERAZIONI = "N3.6"
    case ESENTI = "N4"
    case REGIMEDELMARGINE = "N5"
    case INVERSIONECONTABILEROTTAMI = "N6.1"
    case INVERSIONECONTABILEOROARGENTO = "N6.2"
    case INVERSIONECONTABILESUBAPPALTODILE = "N6.3"
    case INVERSIONECONTABICESSIONEFABBRICATI = "N6.4"
    case INVERSIONECONTABILECESSIONECELLULARI = "N6.5"
    case INVERSIONECONTABILECESSIONEPRODOTTIELETTRONICI = "N6.6"
    case INVERSIONECONTABILEPRESTAZIONICOMPARTOEDILE = "N6.7"
    case INVERSIONECONTABILESETTORENERGETICO = "N6.8"
    case INVERSIONECONTABILEALTRICASI = "N6.9"
    case IVAASSOLTA = "N7"
    
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case NONSOGGETTE = "N2"
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case NONIMPONIBILI = "N3"
    @available(*, deprecated, message: "NON PIU VALIDO DAL GENNAIO 2021")
    case INVERSIONECONTABILE = "N6"


}

// MARK: - <FatturaElettronica>
public struct FatturaElettronica: Codable {
    
    public let fatturaElettronicaHeader: FatturaElettronicaHeader
    public let fatturaElettronicaBody: FatturaElettronicaBody

    public init(fatturaElettronicaHeader: FatturaElettronicaHeader, fatturaElettronicaBody: FatturaElettronicaBody) {
        self.fatturaElettronicaHeader = fatturaElettronicaHeader
        self.fatturaElettronicaBody = fatturaElettronicaBody
    }

    enum CodingKeys: String, CodingKey{
        case fatturaElettronicaHeader = "fatturaelettronicaheader"
        case fatturaElettronicaBody = "fatturaelettronicabody"
    }
}


// MARK: - 1 <FatturaElettronicaHeader>
public struct FatturaElettronicaHeader: Codable {
    public let datiTrasmissione: DatiTrasmissione
    public let cedentePrestatore: CedentePrestatore
    public let rappresentanteFiscale: RappresentanteFiscale?
    public let cessionarioCommittente: CessionarioCommittente
    public let terzoIntermediarioOSoggettoEmittente: TerzoIntermediarioSoggettoEmittente?
    public let soggettoEmittente: SoggettoEmittente?
    
    public init(datiTrasmissione: DatiTrasmissione, cedentePrestatore: CedentePrestatore, rappresentanteFiscale: RappresentanteFiscale?, cessionarioCommittente: CessionarioCommittente, terzoIntermediarioOSoggettoEmittente: TerzoIntermediarioSoggettoEmittente?, soggettoEmittente: SoggettoEmittente?) {
        self.datiTrasmissione = datiTrasmissione
        self.cedentePrestatore = cedentePrestatore
        self.rappresentanteFiscale = rappresentanteFiscale
        self.cessionarioCommittente = cessionarioCommittente
        self.terzoIntermediarioOSoggettoEmittente = terzoIntermediarioOSoggettoEmittente
        self.soggettoEmittente = soggettoEmittente
    }

    enum CodingKeys: String, CodingKey{
        case datiTrasmissione = "datitrasmissione"
        case cedentePrestatore = "cedenteprestatore"
        case rappresentanteFiscale = "rappresentantefiscale"
        case cessionarioCommittente = "cessionariocommittente"
        case terzoIntermediarioOSoggettoEmittente = "terzointermediarioosoggettoemittente"
        case soggettoEmittente = "soggettoemittente"
    }
}

// MARK: - 1.1 <DatiTrasmissione>
public struct DatiTrasmissione: Codable {
    public let idTrasmittente: IDFiscale
    public let progressivoInvio: String
    public let formatoTrasmissione: FormatoTrasmissione
    public let codiceDestinatario: String
    public let contattiTrasmittente: ContattiTrasmittente?
    public let pecDestinatario: String?
    
    public init(idTrasmittente: IDFiscale, progressivoInvio: String, formatoTrasmissione: FormatoTrasmissione, codiceDestinatario: String, contattiTrasmittente: ContattiTrasmittente?, pecDestinatario: String?) {
        self.idTrasmittente = idTrasmittente
        self.progressivoInvio = progressivoInvio
        self.formatoTrasmissione = formatoTrasmissione
        self.codiceDestinatario = codiceDestinatario
        self.contattiTrasmittente = contattiTrasmittente
        self.pecDestinatario = pecDestinatario
    }

    enum CodingKeys: String, CodingKey{
        case idTrasmittente = "idtrasmittente"
        case progressivoInvio = "progressivoinvio"
        case formatoTrasmissione = "formatotrasmissione"
        case codiceDestinatario = "codicedestinatario"
        case contattiTrasmittente = "contattitrasmittente"
        case pecDestinatario = "pecdestinatario"
    }
}

public enum FormatoTrasmissione: String, Codable {
    case FATTURAPA = "FPA12"
    case FATTURAPRIVATI = "FPR12"
}

public struct ContattiTrasmittente: Codable {
    public let telefono: String?
    public let email: String?
    
    public init(telefono: String?, email: String?) {
        self.telefono = telefono
        self.email = email
    }

    enum CodingKeys: String, CodingKey{
        case telefono = "telefono"
        case email = "email"
    }
}

// MARK: - 1.2 <CedentePrestatore>
public struct CedentePrestatore: Codable {
    public let datiAnagrafici: CedentePrestatoreDatiAnagrafici
    public let sede: Indirizzo
    public let stabileOrganizzazione: Indirizzo?
    public let iscrizioneREA: IscrizioneREA?
    public let contatti: Contatti?
    public let riferimentoAmministrazione: String?
    
    public init(datiAnagrafici: CedentePrestatoreDatiAnagrafici, sede: Indirizzo, stabileOrganizzazione: Indirizzo?, iscrizioneREA: IscrizioneREA?, contatti: Contatti?, riferimentoAmministrazione: String?) {
        self.datiAnagrafici = datiAnagrafici
        self.sede = sede
        self.stabileOrganizzazione = stabileOrganizzazione
        self.iscrizioneREA = iscrizioneREA
        self.contatti = contatti
        self.riferimentoAmministrazione = riferimentoAmministrazione
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
        case sede = "sede"
        case stabileOrganizzazione = "stabileorganizzazione"
        case iscrizioneREA = "iscrizionerea"
        case contatti = "contatti"
        case riferimentoAmministrazione = "riferimentoamministrazione"
        
    }
}

public struct CedentePrestatoreDatiAnagrafici: Codable {
    public let idFiscaleIva: IDFiscale
    public let anagrafica: Anagrafica
    public let regimeFiscale: RegimeFiscale
    public let codiceFiscale: String?
    public let alboProfessionale: String?
    public let provinciaAlbo: String?
    public let numeroIscrizioneAlbo: String?
    public let dataIscrizioAlbo: String?
    
    public init(idFiscaleIva: IDFiscale, anagrafica: Anagrafica, regimeFiscale: RegimeFiscale, codiceFiscale: String?, alboProfessionale: String?, provinciaAlbo: String?, numeroIscrizioneAlbo: String?, dataIscrizioAlbo: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.anagrafica = anagrafica
        self.regimeFiscale = regimeFiscale
        self.codiceFiscale = codiceFiscale
        self.alboProfessionale = alboProfessionale
        self.provinciaAlbo = provinciaAlbo
        self.numeroIscrizioneAlbo = numeroIscrizioneAlbo
        self.dataIscrizioAlbo = dataIscrizioAlbo
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case anagrafica = "anagrafica"
        case regimeFiscale = "regimefiscale"
        case provinciaAlbo = "provinciaalbo"
        case codiceFiscale = "codicefiscale"
        case alboProfessionale = "alboprofessionale"
        case numeroIscrizioneAlbo = "numeroiscrizionealbo"
        case dataIscrizioAlbo = "dataiscrizioalbo"
        
    }
}

public struct IscrizioneREA: Codable {
    public let ufficio : String
    public let numeroREA: String
    public let capitaleSociale: Double?
    public let socioUnico: SocioUnico?
    public let statoLiquidazione: StatoLiquidazione
    
    public init(ufficio: String, numeroREA: String, capitaleSociale: Double?, socioUnico: SocioUnico?, statoLiquidazione: StatoLiquidazione) {
        self.ufficio = ufficio
        self.numeroREA = numeroREA
        self.capitaleSociale = capitaleSociale
        self.socioUnico = socioUnico
        self.statoLiquidazione = statoLiquidazione
    }

    enum CodingKeys: String, CodingKey{
        case ufficio = "ufficio"
        case numeroREA =  "numerorea"
        case capitaleSociale = "capitalesociale"
        case socioUnico = "sociounico"
        case statoLiquidazione = "statoliquidazione"
    }
}

public enum StatoLiquidazione: String, Codable {
    case INLIQUIDAZIONE = "LS"
    case NONINLIQUIDAZIONE = "LN"
}

public enum SocioUnico: String, Codable {
    case SOCIOUNICO = "SU"
    case PIUSOCI = "SM"
}

public struct Contatti: Codable {
    public let telefono : String?
    public let fax: String?
    public let email: String?
    
    public init(telefono: String?, fax: String?, email: String?) {
        self.telefono = telefono
        self.fax = fax
        self.email = email
    }

    enum CodingKeys: String, CodingKey{
        case telefono = "telefono"
        case fax =  "fax"
        case email = "email"
    }
}

public enum RegimeFiscale: String, Codable {
    case RF01 = "RF01"
    case RF02 = "RF02"
    case RF03 = "RF03"
    case RF04 = "RF04"
    case RF05 = "RF05"
    case RF06 = "RF06"
    case RF07 = "RF07"
    case RF08 = "RF08"
    case RF09 = "RF09"
    case RF10 = "RF10"
    case RF11 = "RF11"
    case RF12 = "RF12"
    case RF13 = "RF13"
    case RF14 = "RF14"
    case RF15 = "RF15"
    case RF16 = "RF16"
    case RF17 = "RF17"
    case RF18 = "RF18"
    case RF19 = "RF19"
    
}

// MARK: - 1.3 <RappresentateFiscale>
public struct RappresentanteFiscale: Codable {
    public let datiAnagrafici: DatiAnagraficiRappresentante
    
    public init(datiAnagrafici: DatiAnagraficiRappresentante) {
        self.datiAnagrafici = datiAnagrafici
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
    }
}

public struct DatiAnagraficiRappresentante: Codable {
    public let idFiscaleIva: IDFiscale
    public let codiceFiscale: String?
    public let anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }
}

// MARK: - 1.4 <CessionarioCommittente>
public struct CessionarioCommittente: Codable {
    public let datiAnagrafici: CessionarioCommittenteDatiAnagrafici
    public let sede: Indirizzo
    public let stabileOrganizzazione: Indirizzo?
    public let rappresentanteFiscale: CessionarioCommittenteRappresentanteFiscale?
    
    public init(datiAnagrafici: CessionarioCommittenteDatiAnagrafici, sede: Indirizzo, stabileOrganizzazione: Indirizzo?, rappresentanteFiscale: CessionarioCommittenteRappresentanteFiscale?) {
        self.datiAnagrafici = datiAnagrafici
        self.sede = sede
        self.stabileOrganizzazione = stabileOrganizzazione
        self.rappresentanteFiscale = rappresentanteFiscale
    }
    
    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
        case sede = "sede"
        case stabileOrganizzazione = "stabileorganizzazione"
        case rappresentanteFiscale = "rappresentantefiscale"
    }
}

public struct CessionarioCommittenteDatiAnagrafici: Codable {
    public let idFiscaleIva: IDFiscale?
    public let codiceFiscale: String?
    public let anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale?, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }
}

public struct CessionarioCommittenteRappresentanteFiscale: Codable {
    public let idFiscaleIva: IDFiscale
    public let denominazione: String?
    public let nome: String?
    public let cognome: String?
    
    public init(idFiscaleIva: IDFiscale, denominazione: String?, nome: String?, cognome: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.denominazione = denominazione
        self.nome = nome
        self.cognome = cognome
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case denominazione = "denominazione"
        case nome = "nome"
        case cognome = "cognome"
    }
}

// MARK: - 1.5 <TerzoIntermediarioOSoggettoEmittente>
public struct TerzoIntermediarioSoggettoEmittente: Codable {
    public let datiAnagrafici: DatiAnagraficiTerzoIntermediario
    
    public init(datiAnagrafici: DatiAnagraficiTerzoIntermediario) {
        self.datiAnagrafici = datiAnagrafici
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagrafici = "datianagrafici"
    }
}

public struct DatiAnagraficiTerzoIntermediario: Codable {
    public let idFiscaleIva: IDFiscale?
    public let codiceFiscale: String?
    public let anagrafica: Anagrafica
    
    public init(idFiscaleIva: IDFiscale?, codiceFiscale: String?, anagrafica: Anagrafica) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
    }
}

// MARK: - 1.6 <SoggettoEmittente>
public enum SoggettoEmittente: String, Codable {
    case TERZO = "TZ"
    case CESSIONARIOCOMMITTENTE = "CC"
}

// MARK: - 2 <FatturaElettronicaBody>
public struct FatturaElettronicaBody: Codable {
    
    public let datiGenerali: DatiGenerali
    public let datiBeniServizi: DatiBeniServizi
    public let datiVeicoli: DatiVeicoli?
    public var datiPagamento: [DatiPagamento] = []
    public let allegati: [Allegati]?
    
    public init(datiGenerali: DatiGenerali, datiBeniServizi: DatiBeniServizi, datiVeicoli: DatiVeicoli?, datiPagamento: [DatiPagamento] = [], allegati: [Allegati]?) {
        self.datiGenerali = datiGenerali
        self.datiBeniServizi = datiBeniServizi
        self.datiVeicoli = datiVeicoli
        self.datiPagamento = datiPagamento
        self.allegati = allegati
    }
    
    enum CodingKeys: String, CodingKey{
        case allegati = "allegati"
        case datiPagamento = "datipagamento"
        case datiGenerali = "datigenerali"
        case datiBeniServizi = "datibeniservizi"
        case datiVeicoli = "dativeicoli"
    }
}

// MARK: - 2.1 <DatiGenerali>
public struct DatiGenerali: Codable {
    public let datiGeneraliDocumento: DatiGeneraliDocumento
    public let datiOrdineAcquisto: [DatiDocumentiCorrelati]?
    public let datiContratto: [DatiDocumentiCorrelati]?
    public let datiConvenzione: [DatiDocumentiCorrelati]?
    public let datiRicezione: [DatiDocumentiCorrelati]?
    public let datiFattureCollegate: [DatiDocumentiCorrelati]?
    public let datiSal: [DatiSAL]?
    public let datiDdt: [DatiDDT]?
    public let datiTrasporto: DatiTrasporto?
    public let fatturaPrincipale: FatturaPrincipale?
    
    public init(datiGeneraliDocumento: DatiGeneraliDocumento, datiOrdineAcquisto: [DatiDocumentiCorrelati]?, datiContratto: [DatiDocumentiCorrelati]?, datiConvenzione: [DatiDocumentiCorrelati]?, datiRicezione: [DatiDocumentiCorrelati]?, datiFattureCollegate: [DatiDocumentiCorrelati]?, datiSal: [DatiSAL]?, datiDdt: [DatiDDT]?, datiTrasporto: DatiTrasporto?, fatturaPrincipale: FatturaPrincipale?) {
        self.datiGeneraliDocumento = datiGeneraliDocumento
        self.datiOrdineAcquisto = datiOrdineAcquisto
        self.datiContratto = datiContratto
        self.datiConvenzione = datiConvenzione
        self.datiRicezione = datiRicezione
        self.datiFattureCollegate = datiFattureCollegate
        self.datiSal = datiSal
        self.datiDdt = datiDdt
        self.datiTrasporto = datiTrasporto
        self.fatturaPrincipale = fatturaPrincipale
    }
    
    enum CodingKeys: String, CodingKey{
        case datiGeneraliDocumento = "datigeneralidocumento"
        case datiOrdineAcquisto = "datiordineacquisto"
        case datiContratto = "daticontratto"
        case datiConvenzione = "daticonvenzione"
        case datiRicezione = "datiricezione"
        case datiFattureCollegate = "datifatturecollegate"
        case datiSal = "datisal"
        case datiDdt = "datiddt"
        case datiTrasporto = "datitrasporto"
        case fatturaPrincipale = "fatturaprincipale"
    }
}

public struct DatiGeneraliDocumento: Codable {
    public let tipoDocumento: TipoDocumento
    public let divisa: String
    public let data: Date
    public let numero: String
    public let datiRitenuta: [DatiRitenuta]?
    public let datiBollo: DatiBollo?
    public let datiCassaPrevidenziale: [DatiCassaPrevidenziale]?
    public let scontoMaggiorazione: [ScontoMaggiorazione]?
    public let importoTotaleDocumento: Double?
    public let arrotondamento: Double?
    public let causale: [String]?
    public let art73: String?
    
    public init(tipoDocumento: TipoDocumento, divisa: String, data: Date, numero: String, datiRitenuta: [DatiRitenuta]?, datiBollo: DatiBollo?, datiCassaPrevidenziale: [DatiCassaPrevidenziale]?, scontoMaggiorazione: [ScontoMaggiorazione]?, importoTotaleDocumento: Double?, arrotondamento: Double?, causale: [String]?, art73: String?) {
        self.tipoDocumento = tipoDocumento
        self.divisa = divisa
        self.data = data
        self.numero = numero
        self.datiRitenuta = datiRitenuta
        self.datiBollo = datiBollo
        self.datiCassaPrevidenziale = datiCassaPrevidenziale
        self.scontoMaggiorazione = scontoMaggiorazione
        self.importoTotaleDocumento = importoTotaleDocumento
        self.arrotondamento = arrotondamento
        self.causale = causale
        self.art73 = art73
    }
    
    enum CodingKeys: String, CodingKey {
        case tipoDocumento = "tipodocumento"
        case divisa = "divisa"
        case data = "data"
        case numero = "numero"
        case datiRitenuta = "datiritenuta"
        case datiBollo = "datibollo"
        case datiCassaPrevidenziale = "daticassaprevidenziale"
        case scontoMaggiorazione = "scontomaggiorazione"
        case importoTotaleDocumento = "importototaledocumento"
        case arrotondamento = "arrotondamento"
        case causale = "causale"
        case art73 = "art73"
    }
}

public enum TipoDocumento: String, Codable {
    case FATTURA = "TD01"
    case ACCONTOSUFATTURA = "TD02"
    case ACCONTOSUPARCELLA = "TD03"
    case NOTADICREDITO = "TD04"
    case NOTADIDEBITO = "TD05"
    case PARCELLA = "TD06"
    case TD16 = "TD16"
    case TD17 = "TD17"
    case TD19 = "TD19"
    case TD20 = "TD20"
    case TD21 = "TD21"
    case TD22 = "TD22"
    case TD23 = "TD23"
    case TD24 = "TD24"
    case TD25 = "TD25"
    case TD26 = "TD26"
    case TD27 = "TD27"
}

public struct DatiRitenuta: Codable {
    public let tipoRitenuta: TipoRitenuta
    public let importoRitenuta: Double
    public let aliquotaRitenuta: Double
    public let causalePagamento: CausalePagamento
    
    public init(tipoRitenuta: TipoRitenuta, importoRitenuta: Double, aliquotaRitenuta: Double, causalePagamento: CausalePagamento) {
        self.tipoRitenuta = tipoRitenuta
        self.importoRitenuta = importoRitenuta
        self.aliquotaRitenuta = aliquotaRitenuta
        self.causalePagamento = causalePagamento
    }
    
    enum CodingKeys: String, CodingKey{
        case tipoRitenuta = "tiporitenuta"
        case importoRitenuta = "importoritenuta"
        case aliquotaRitenuta = "aliquotaritenuta"
        case causalePagamento = "causalepagamento"
    }
}

public enum TipoRitenuta: String, Codable {
    case RT01 = "RT01"
    case RT02 = "RT02"
    case RT03 = "RT03"
    case RT04 = "RT04"
    case RT05 = "RT05"
    case RT06 = "RT06"
}

public enum CausalePagamento: String, Codable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case G = "G"
    case H = "H"
    case I = "I"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
    case L1 = "L1"
    case M1 = "M1"
    case O1 = "O1"
    case V1 = "V1"
}

public struct DatiBollo: Codable {
    public let bolloVirtuale: String
    public let importoBollo: Double?
    
    public init(bolloVirtuale: String, importoBollo: Double?) {
        self.bolloVirtuale = bolloVirtuale
        self.importoBollo = importoBollo
    }
    
    enum CodingKeys: String, CodingKey{
        case bolloVirtuale = "bollovirtuale"
        case importoBollo = "importobollo"
    }
}

public struct DatiCassaPrevidenziale: Codable {
    public let tipoCassa: TipoCassa
    public let alCassa: Double
    public let importoContributoCassa: Double
    public let imponibileCassa: Double?
    public let aliquotaIVA: Double
    @PABool public var ritenuta: Bool?
    public let natura: Natura?
    public let riferimentoAmministrazione: String?
    
    public init(tipoCassa: TipoCassa, alCassa: Double, importoContributoCassa: Double, imponibileCassa: Double?, aliquotaIVA: Double, ritenuta: Bool?, natura: Natura?, riferimentoAmministrazione: String?) {
        self.tipoCassa = tipoCassa
        self.alCassa = alCassa
        self.importoContributoCassa = importoContributoCassa
        self.imponibileCassa = imponibileCassa
        self.aliquotaIVA = aliquotaIVA
        self.ritenuta = ritenuta
        self.natura = natura
        self.riferimentoAmministrazione = riferimentoAmministrazione
    }
    
    enum CodingKeys: String, CodingKey{
        case tipoCassa = "tipocassa"
        case alCassa = "alcassa"
        case importoContributoCassa = "importocontributocassa"
        case imponibileCassa = "imponibilecassa"
        case aliquotaIVA = "aliquotaiva"
        case ritenuta = "ritenuta"
        case natura = "natura"
        case riferimentoAmministrazione = "riferimentoamministrazione"
    }
}

public enum TipoCassa: String, Codable {
    case TC01 = "TC01"
    case TC02 = "TC02"
    case TC03 = "TC03"
    case TC04 = "TC04"
    case TC05 = "TC05"
    case TC06 = "TC06"
    case TC07 = "TC07"
    case TC08 = "TC08"
    case TC09 = "TC09"
    case TC10 = "TC10"
    case TC11 = "TC11"
    case TC12 = "TC12"
    case TC13 = "TC13"
    case TC14 = "TC14"
    case TC15 = "TC15"
    case TC16 = "TC16"
    case TC17 = "TC17"
    case TC18 = "TC18"
    case TC19 = "TC19"
    case TC20 = "TC20"
    case TC21 = "TC21"
    case TC22 = "TC22"
}

public struct ScontoMaggiorazione: Codable {
    public let tipo: TipoScontoMaggiorazione
    public let percentuale: Double?
    public let importo: Double?
    
    public init(tipo: TipoScontoMaggiorazione, percentuale: Double?, importo: Double?) {
        self.tipo = tipo
        self.percentuale = percentuale
        self.importo = importo
    }

    
    enum CodingKeys: String, CodingKey{
        case tipo = "tipo"
        case percentuale = "percentuale"
        case importo = "importo"
    }
}

public enum TipoScontoMaggiorazione: String, Codable {
    case SCONTO = "SC"
    case MAGGIORAZIONE = "MG"
}

public struct DatiDocumentiCorrelati: Codable {
    public let riferimentoNumeroLinea: [Int]?
    public let idDocumento: String
    public let numItem: String?
    public let codiceCup: String?
    public let codiceCig: String?
    public let data: Date?
    public let codiceCommessaConvenzione: String?
    
    public init(riferimentoNumeroLinea: [Int]?, idDocumento: String, numItem: String?, codiceCup: String?, codiceCig: String?, data: Date?, codiceCommessaConvenzione: String?) {
        self.riferimentoNumeroLinea = riferimentoNumeroLinea
        self.idDocumento = idDocumento
        self.numItem = numItem
        self.codiceCup = codiceCup
        self.codiceCig = codiceCig
        self.data = data
        self.codiceCommessaConvenzione = codiceCommessaConvenzione
    }
    
    enum CodingKeys: String, CodingKey{
        case riferimentoNumeroLinea = "riferimentonumerolinea"
        case idDocumento = "iddocumento"
        case numItem = "numitem"
        case codiceCup = "codicecup"
        case codiceCig = "codicecig"
        case data = "data"
        case codiceCommessaConvenzione = "codicecommessaconvenzione"
    }
}

public struct DatiSAL: Codable {
    public let riferimentoFase: Int
    
    public init(riferimentoFase: Int) {
        self.riferimentoFase = riferimentoFase
    }

    
    enum CodingKeys: String, CodingKey{
        case riferimentoFase = "riferimentofase"
    }
}

public struct DatiDDT: Codable {
    public let numeroDdt: String
    public let dataDdt: Date
    public let riferimentoNumeroLinea: [Int]?
    
    public init(numeroDdt: String, dataDdt: Date, riferimentoNumeroLinea: [Int]?) {
        self.numeroDdt = numeroDdt
        self.dataDdt = dataDdt
        self.riferimentoNumeroLinea = riferimentoNumeroLinea
    }

    
    enum CodingKeys: String, CodingKey{
        case numeroDdt = "numeroddt"
        case dataDdt = "dataddt"
        case riferimentoNumeroLinea = "riferimentonumerolinea"
    }
}

public struct DatiTrasporto: Codable {
    public let datiAnagraficiVettore: DatiAnagraficiVettore?
    public let mezzoTrasporto: String?
    public let causaleTrasporto: String?
    public let numeroColli: Int?
    public let descrizione: String?
    public let unitaMisuraPeso: String?
    public let pesoLordo: Double?
    public let pesoNetto: Double?
    public let dataOraRitiro: Date?
    public let dataInizioTrasporto: Date?
    public let tipoResa: String?
    public let indirizzoResa: Indirizzo?
    public let dataOraConsegna: Date?
    
    public init(datiAnagraficiVettore: DatiAnagraficiVettore?, mezzoTrasporto: String?, causaleTrasporto: String?, numeroColli: Int?, descrizione: String?, unitaMisuraPeso: String?, pesoLordo: Double?, pesoNetto: Double?, dataOraRitiro: Date?, dataInizioTrasporto: Date?, tipoResa: String?, indirizzoResa: Indirizzo?, dataOraConsegna: Date?) {
        self.datiAnagraficiVettore = datiAnagraficiVettore
        self.mezzoTrasporto = mezzoTrasporto
        self.causaleTrasporto = causaleTrasporto
        self.numeroColli = numeroColli
        self.descrizione = descrizione
        self.unitaMisuraPeso = unitaMisuraPeso
        self.pesoLordo = pesoLordo
        self.pesoNetto = pesoNetto
        self.dataOraRitiro = dataOraRitiro
        self.dataInizioTrasporto = dataInizioTrasporto
        self.tipoResa = tipoResa
        self.indirizzoResa = indirizzoResa
        self.dataOraConsegna = dataOraConsegna
    }

    enum CodingKeys: String, CodingKey{
        case datiAnagraficiVettore = "datianagraficivettore"
        case mezzoTrasporto = "mezzotrasporto"
        case causaleTrasporto = "causaletrasporto"
        case numeroColli = "numerocolli"
        case descrizione = "descrizione"
        case unitaMisuraPeso = "unitamisurapeso"
        case pesoLordo = "pesolordo"
        case pesoNetto = "pesonetto"
        case dataOraRitiro = "dataoraritiro"
        case dataInizioTrasporto = "datainiziotrasporto"
        case tipoResa = "tiporesa"
        case indirizzoResa = "indirizzoresa"
        case dataOraConsegna = "dataoraconsegna"
    }
    
}

public struct DatiAnagraficiVettore: Codable {
    public let idFiscaleIva: IDFiscale
    public let codiceFiscale: String?
    public let anagrafica: Anagrafica
    public let numeroLicenzaGuida: String?
    
    public init(idFiscaleIva: IDFiscale, codiceFiscale: String?, anagrafica: Anagrafica, numeroLicenzaGuida: String?) {
        self.idFiscaleIva = idFiscaleIva
        self.codiceFiscale = codiceFiscale
        self.anagrafica = anagrafica
        self.numeroLicenzaGuida = numeroLicenzaGuida
    }

    enum CodingKeys: String, CodingKey{
        case idFiscaleIva = "idfiscaleiva"
        case codiceFiscale = "codicefiscale"
        case anagrafica = "anagrafica"
        case numeroLicenzaGuida = "numerolicenzaguida"
    }
}

public struct FatturaPrincipale: Codable {
    public let numeroFatturaPrincipale: String
    public let dataFatturaPrincipale: Date
    
    public init(numeroFatturaPrincipale: String, dataFatturaPrincipale: Date) {
        self.numeroFatturaPrincipale = numeroFatturaPrincipale
        self.dataFatturaPrincipale = dataFatturaPrincipale
    }

    enum CodingKeys: String, CodingKey{
        case numeroFatturaPrincipale = "numerofatturaprincipale"
        case dataFatturaPrincipale = "datafatturaprincipale"
    }
}

// MARK: - 2.2 <DatiBeniServizi>
public struct DatiBeniServizi: Codable {
    public let dettaglioLinee: [DettaglioLinee]
    public let datiRiepilogo: [DatiRiepilogo]
    
    public init(dettaglioLinee: [DettaglioLinee], datiRiepilogo: [DatiRiepilogo]) {
        self.dettaglioLinee = dettaglioLinee
        self.datiRiepilogo = datiRiepilogo
    }

    enum CodingKeys: String, CodingKey{
        case dettaglioLinee = "dettagliolinee"
        case datiRiepilogo = "datiriepilogo"
    }
}

public struct DettaglioLinee: Codable {
    public let codiceArticolo: [CodiceArticolo]?
    public let numeroLinea: Int
    public let tipoCessionePrestazione: TipoCessionePrestazione?
    public let descrizione: String
    public let quantita: Double?
    public let unitaMisura: String?
    public let dataInizioPeriodo: Date?
    public let dataFinePeriodo: Date?
    public let prezzoUnitario: Double
    public let scontoMaggiorazione: [ScontoMaggiorazione]?
    public let prezzoTotale: Double
    public let aliquotaIva: Double
    @PABool public var ritenuta: Bool?
    public let natura: Natura?
    public let riferimentoAmministrazione: String?
    public let altriDatiGestionali: [AltriDatiGestionali]?
    
    public init(codiceArticolo: [CodiceArticolo]?, numeroLinea: Int, tipoCessionePrestazione: TipoCessionePrestazione?, descrizione: String, quantita: Double?, unitaMisura: String?, dataInizioPeriodo: Date?, dataFinePeriodo: Date?, prezzoUnitario: Double, scontoMaggiorazione: [ScontoMaggiorazione]?, prezzoTotale: Double, aliquotaIva: Double, ritenuta: Bool?, natura: Natura?, riferimentoAmministrazione: String?, altriDatiGestionali: [AltriDatiGestionali]?) {
        self.codiceArticolo = codiceArticolo
        self.numeroLinea = numeroLinea
        self.tipoCessionePrestazione = tipoCessionePrestazione
        self.descrizione = descrizione
        self.quantita = quantita
        self.unitaMisura = unitaMisura
        self.dataInizioPeriodo = dataInizioPeriodo
        self.dataFinePeriodo = dataFinePeriodo
        self.prezzoUnitario = prezzoUnitario
        self.scontoMaggiorazione = scontoMaggiorazione
        self.prezzoTotale = prezzoTotale
        self.aliquotaIva = aliquotaIva
        self.ritenuta = ritenuta
        self.natura = natura
        self.riferimentoAmministrazione = riferimentoAmministrazione
        self.altriDatiGestionali = altriDatiGestionali
    }

    
    enum CodingKeys: String, CodingKey{
        case codiceArticolo = "codicearticolo"
        case altriDatiGestionali = "altridatigestionali"
        case numeroLinea = "numerolinea"
        case tipoCessionePrestazione = "tipocessioneprestazione"
        case descrizione = "descrizione"
        case quantita = "quantita"
        case unitaMisura = "unitamisura"
        case dataInizioPeriodo = "datainizioperiodo"
        case dataFinePeriodo = "datafineperiodo"
        case prezzoUnitario = "prezzounitario"
        case scontoMaggiorazione = "scontomaggiorazione"
        case prezzoTotale = "prezzototale"
        case aliquotaIva = "aliquotaiva"
        case ritenuta = "ritenuta"
        case natura = "natura"
        case riferimentoAmministrazione = "riferimentoamministrazione"
    }
}

public struct DatiRiepilogo: Codable {
    public let aliquotaIva: Double
    public let natura: Natura?
    public let speseAccessorie: Double?
    public let arrotondamento: Double?
    public let imponibileImporto: Double
    public let imposta: Double
    public let esigibilitaIva: EsigibilitaIVA?
    public let riferimentoNormativo: String?
    
    public init(aliquotaIva: Double, natura: Natura?, speseAccessorie: Double?, arrotondamento: Double?, imponibileImporto: Double, imposta: Double, esigibilitaIva: EsigibilitaIVA?, riferimentoNormativo: String?) {
        self.aliquotaIva = aliquotaIva
        self.natura = natura
        self.speseAccessorie = speseAccessorie
        self.arrotondamento = arrotondamento
        self.imponibileImporto = imponibileImporto
        self.imposta = imposta
        self.esigibilitaIva = esigibilitaIva
        self.riferimentoNormativo = riferimentoNormativo
    }

    enum CodingKeys: String, CodingKey{
        case aliquotaIva = "aliquotaiva"
        case natura = "natura"
        case speseAccessorie = "speseaccessorie"
        case arrotondamento = "arrotondamento"
        case imponibileImporto = "imponibileimporto"
        case imposta = "imposta"
        case esigibilitaIva = "esigibilitaiva"
        case riferimentoNormativo = "riferimentonormativo"
    }
}

public enum EsigibilitaIVA: String, Codable {
    case ESIGIBILITADIFFERITA = "D"
    case ESIGIBILITAIMMEDIATA = "I"
    case SCISSIONEDEIPAGAMENTI = "S"
}

public enum TipoCessionePrestazione: String, Codable {
    case SCONTO = "SC"
    case PREMIO = "PR"
    case ABBUONO = "AB"
    case SPESACCESSORIA = "AC"
}

public struct CodiceArticolo: Codable {
    public let codiceTipo: String
    public let codiceValore: String
    
    public init(codiceTipo: String, codiceValore: String) {
        self.codiceTipo = codiceTipo
        self.codiceValore = codiceValore
    }

    enum CodingKeys: String, CodingKey{
        case codiceTipo = "codicetipo"
        case codiceValore = "codicevalore"
    }
}

public struct AltriDatiGestionali: Codable {
    public let tipoDato: String
    public let riferimentoTesto: String?
    public let riferimentoNumero: Double?
    public let riferimentoData: Date?
    
    public init(tipoDato: String, riferimentoTesto: String?, riferimentoNumero: Double?, riferimentoData: Date?) {
        self.tipoDato = tipoDato
        self.riferimentoTesto = riferimentoTesto
        self.riferimentoNumero = riferimentoNumero
        self.riferimentoData = riferimentoData
    }

    enum CodingKeys: String, CodingKey{
        case tipoDato = "tipodato"
        case riferimentoTesto = "riferimentotesto"
        case riferimentoNumero = "riferimentonumero"
        case riferimentoData = "riferimentodata"
    }
}

// MARK: - 2.3 <DatiVeicoli>
public struct DatiVeicoli: Codable {
    public let data: Date
    public let totalePercorso: String

    public init(data: Date, totalePercorso: String) {
        self.data = data
        self.totalePercorso = totalePercorso
    }

    enum CodingKeys: String, CodingKey{
        case data = "data"
        case totalePercorso = "totalepercorso"
    }
}

// MARK: - 2.4 <DatiPagamento>
public struct DatiPagamento: Codable {
    public let dettaglioPagamento: [DettaglioPagamento]
    public let condizioniPagamento: CondizioniPagamento
    
    public init(dettaglioPagamento: [DettaglioPagamento], condizioniPagamento: CondizioniPagamento) {
        self.dettaglioPagamento = dettaglioPagamento
        self.condizioniPagamento = condizioniPagamento
    }

    
    enum CodingKeys: String, CodingKey{
        case dettaglioPagamento = "dettagliopagamento"
        case condizioniPagamento = "condizionipagamento"
    }
}

public struct DettaglioPagamento: Codable {
    public let beneficiario: String?
    public let modalitaPagamento: ModalitaPagamento
    public let dataRiferimentoTerminiPagamento: Date?
    public let giorniTerminiPagamento: Int?
    public let dataScadenzaPagamento: Date?
    public let importoPagamento: Double
    public let codUfficioPostale: String?
    public let cognomeQuietanzante: String?
    public let nomeQuietanzante: String?
    public let cfQuietanzante: String?
    public let titoloQuietanzante: String?
    public let istitutoFinanziario: String?
    public let iban: String?
    public let abi: Int?
    public let cab: Int?
    public let bic: String?
    public let scontoPagamentoAnticipato: Double?
    public let dataLimitePagamentoAnticipato: Date?
    public let penalitaPagamentiRitardati: Double?
    public let dataDecorrenzaPenale: Date?
    public let codicePagamento: String?
    
    public init(beneficiario: String?, modalitaPagamento: ModalitaPagamento, dataRiferimentoTerminiPagamento: Date?, giorniTerminiPagamento: Int?, dataScadenzaPagamento: Date?, importoPagamento: Double, codUfficioPostale: String?, cognomeQuietanzante: String?, nomeQuietanzante: String?, cfQuietanzante: String?, titoloQuietanzante: String?, istitutoFinanziario: String?, iban: String?, abi: Int?, cab: Int?, bic: String?, scontoPagamentoAnticipato: Double?, dataLimitePagamentoAnticipato: Date?, penalitaPagamentiRitardati: Double?, dataDecorrenzaPenale: Date?, codicePagamento: String?) {
        self.beneficiario = beneficiario
        self.modalitaPagamento = modalitaPagamento
        self.dataRiferimentoTerminiPagamento = dataRiferimentoTerminiPagamento
        self.giorniTerminiPagamento = giorniTerminiPagamento
        self.dataScadenzaPagamento = dataScadenzaPagamento
        self.importoPagamento = importoPagamento
        self.codUfficioPostale = codUfficioPostale
        self.cognomeQuietanzante = cognomeQuietanzante
        self.nomeQuietanzante = nomeQuietanzante
        self.cfQuietanzante = cfQuietanzante
        self.titoloQuietanzante = titoloQuietanzante
        self.istitutoFinanziario = istitutoFinanziario
        self.iban = iban
        self.abi = abi
        self.cab = cab
        self.bic = bic
        self.scontoPagamentoAnticipato = scontoPagamentoAnticipato
        self.dataLimitePagamentoAnticipato = dataLimitePagamentoAnticipato
        self.penalitaPagamentiRitardati = penalitaPagamentiRitardati
        self.dataDecorrenzaPenale = dataDecorrenzaPenale
        self.codicePagamento = codicePagamento
    }

    enum CodingKeys: String, CodingKey{
        case beneficiario = "beneficiario"
        case modalitaPagamento = "modalitapagamento"
        case dataRiferimentoTerminiPagamento = "datariferimentoterminipagamento"
        case giorniTerminiPagamento = "giorniterminipagamento"
        case dataScadenzaPagamento = "datascadenzapagamento"
        case importoPagamento = "importopagamento"
        case codUfficioPostale = "codufficiopostale"
        case cognomeQuietanzante = "cognomequietanzante"
        case nomeQuietanzante = "nomequietanzante"
        case cfQuietanzante = "cfquietanzante"
        case titoloQuietanzante = "titoloquietanzante"
        case istitutoFinanziario = "istitutofinanziario"
        case iban = "iban"
        case abi = "abi"
        case cab = "cab"
        case bic = "bic"
        case scontoPagamentoAnticipato = "scontopagamentoanticipato"
        case dataLimitePagamentoAnticipato = "datalimitepagamentoanticipato"
        case penalitaPagamentiRitardati = "penalitapagamentiritardati"
        case dataDecorrenzaPenale = "datadecorrenzapenale"
        case codicePagamento = "codicepagamento"
    }
}

public enum ModalitaPagamento: String, Codable {
    case CONTANTI = "MP01"
    case ASSEGNO = "MP02"
    case ASSEGNO_CIRCOLARE = "MP03"
    case CONTANTI_PRESSO_TESORERIA = "MP04"
    case BONIFICO = "MP05"
    case VAGLIA_CAMBIARIO = "MP06"
    case BOLLETTINO_BANCARIO = "MP07"
    case CARTA_DI_PAGAMENTO = "MP08"
    case RID = "MP09"
    case RID_UTENZE = "MP10"
    case RID_VELOCE = "MP11"
    case RIBA = "MP12"
    case MAV = "MP13"
    case QUIETANZA_ERARIO = "MP14"
    case GIROCONTO_SU_CONTI_DI_CONTABILITA_SPECIALE = "MP15"
    case DOMICIALIAZIONE_BANCARIA = "MP16"
    case DOMICIALIAZIONE_POSTALE = "MP17"
    case BOLLETTINO_DI_CC_POSTALE = "MP18"
    case SEPA_DIRECT_DEBIT = "MP19"
    case SEPA_DIRECT_DEBIT_CORE = "MP20"
    case SEPA_DIRECT_DEBIT_B2B = "MP21"
    case TRATTENUTA_SU_SOMME_GIA_RISCOSSE = "MP22"
    case PAGO_PA = "MP23"
}

public enum CondizioniPagamento: String, Codable {
    case PAGAMENTOARATE = "TP01"
    case PAGAMENTOCOMPLETO = "TP02"
    case ANTICIPO = "TP03"
}

// MARK: - 2.5 <Allegati>
public struct Allegati: Codable {
    public let nomeAttachment: String
    public let algoritmoCompressione: String?
    public let formatoAttachment: String?
    public let descrizioneAttachment: String?
    public let attachment: String
    
    public init(nomeAttachment: String, algoritmoCompressione: String?, formatoAttachment: String?, descrizioneAttachment: String?, attachment: String) {
        self.nomeAttachment = nomeAttachment
        self.algoritmoCompressione = algoritmoCompressione
        self.formatoAttachment = formatoAttachment
        self.descrizioneAttachment = descrizioneAttachment
        self.attachment = attachment
    }

    enum CodingKeys: String, CodingKey{
        case nomeAttachment = "nomeattachment"
        case algoritmoCompressione = "algoritmocompressione"
        case formatoAttachment = "formatoattachment"
        case descrizioneAttachment = "descrizioneattachment"
        case attachment = "attachment"
    }
    
}
