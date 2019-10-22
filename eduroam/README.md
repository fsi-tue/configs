# eduroam

Informationen zu `eduroam` an der Uni Tübingen finden sich
[hier](https://uni-tuebingen.de/einrichtungen/zentrum-fuer-datenverarbeitung/dienstleistungen/netzdienste/netzzugang/roaming/eduroaming/).
Dort gibt es auch Installationsanleitungen zu verschiedenen Plattformen.

## Details (WIP)

Aktuell scheint in Tübingen nur `PEAP-MSCHAPv2` (`EAP-PEAPv0`/`EAP-MSCHAPv2`) zu
funktionieren, dies sollte dafür aber immerhin überall funktionieren, da es die
am weitesten verbreitete Methode ist.

Anderswo wird häufig noch `TTLS-PAP` unterstützt und `TTLS-MSCHAPv2`
(TODO: testen).

## netctl

Die richtigen Einstellungen zu finden, damit `netctl` sich richtig mit eduroam
verbindet, kann schwierig sein. [hier](./netctl) findet ihr eine
Beispiel-Konfiguration, die ihr unter `/etc/netctl/PROFILNAME` ablegt.
Da `netctl` auf `wpa_supplicant` basiert kann man hier auch direkt auf eine
`wpa_supplicant` Konfigurationsdatei verweisen: [eduroam](./wpa_supplicant).

## wpa_supplicant

Folgende Beispielkonfiguration kann als Vorlage verwendet werden und bei Bedarf
auch um weitere `network={...}`-Sektionen erweitert werden:
[eduroam.conf](./wpa_supplicant).

## Android

### TeleSec Zertifikat importieren

Man kann z. B.
`openssl x509 -inform PEM -outform DER -in /etc/ssl/certs/T-TeleSec_GlobalRoot_Class_2.pem -out ~/T-TeleSec_GlobalRoot_Class_2.crt`
unter einem GNU/Linux System ausführen und `~/T-TeleSec_GlobalRoot_Class_2.crt`
auf sein Android Smartphone importieren (der Inhalt sollte identisch zu
[T-TeleSec_GlobalRoot_Class_2.crt](https://www.pki.dfn.de/fileadmin/PKI/zertifikate/T-TeleSec_GlobalRoot_Class_2.crt)
vom DFN sein).

### Zertifikate allgemein

Die System-Zertifikate findet man unter `/etc/security/cacerts/`.

Die Benutzer-Zertifikate sollten sich im Ordner `/data/misc/keystore/user_0/`
befinden.
Beim Importieren von Benutzer-Zertifikaten werden nur DER kodierte X.509
Zertifikate mit der Dateiendung `.crt` (alternativ wohl auch `.cer`)
unterstützt.
