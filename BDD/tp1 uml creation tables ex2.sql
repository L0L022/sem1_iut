CREATE TABLE ORGANISME (
  CODEORGA SERIAL PRIMARY KEY,
  ADRESSE VARCHAR(75) NOT NULL,
  VILLE VARCHAR(50) NOT NULL,
  CP DECIMAL(5, 0) NOT NULL,
  DENOMINATION VARCHAR(100) NOT NULL,
  TEL VARCHAR(15) NULL
);

CREATE TABLE COURS (
  REFCOURS SERIAL PRIMARY KEY,
  CODEORGA INTEGER NOT NULL,
  DESIGNATION TEXT NOT NULL,
  PRIX REAL NOT NULL,
  LIEU VARCHAR(100) NOT NULL,
  NBMINPARTICIP INTEGER DEFAULT 15,
  DUREE INTEGER NOT NULL,
  CONSTRAINT FK_COURS_CODEORGA FOREIGN KEY (CODEORGA) REFERENCES ORGANISME(CODEORGA)
);

CREATE TABLE QUALIFICATION (
  CODEQUALIF SERIAL PRIMARY KEY,
  LIBQUALIF VARCHAR(100) NOT NULL
);

CREATE TABLE CATEGORIE (
  CODECAT SERIAL PRIMARY KEY,
  LIBCAT VARCHAR(100) NOT NULL
);

CREATE TABLE DEPARTEMENT (
  NOMDEP VARCHAR(50) PRIMARY KEY,
  RESDEP VARCHAR(50) NOT NULL
);

CREATE TABLE EMPLOYER (
  NUMEMP SERIAL PRIMARY KEY,
  CODEQUALIF INTEGER NOT NULL,
  CODECAT INTEGER NOT NULL,
  NOMDEP INTEGER NOT NULL,
  NOMEMP VARCHAR(50) NOT NULL,
  PREEMP VARCHAR(50) NOT NULL,
  SEXEEMP CHAR(1) NOT NULL,
  DATENAIS DATE NULL,
  DATEEMP DATE NOT NULL,
  CONSTRAINT FK_EMPLOYER_CODEQUALIF FOREIGN KEY (CODEQUALIF) REFERENCES QUALIFICATION(CODEQUALIF),
  CONSTRAINT FK_EMPLOYER_CODECAT FOREIGN KEY (CODECAT) REFERENCES CATEGORIE(CODECAT),
  CONSTRAINT FK_EMPLOYER_NOMDEP FOREIGN KEY (NOMDEP) REFERENCES DEPARTEMENT(NOMDEP)
);

CREATE TABLE INSCRIRE (
  REFCOURS INTEGER,
  NUMEMP INTEGER,
  CONSTRAINT PK_INSCRIRE PRIMARY KEY (REFCOURS, NUMEMP),
  CONSTRAINT FK_INSCRIRE_REFCOURS FOREIGN KEY (REFCOURS) REFERENCES COURS(REFCOURS),
  CONSTRAINT FK_INSCRIRE_NUMEMP FOREIGN KEY (NUMEMP) REFERENCES EMPLOYER(NUMEMP)
);

CREATE TABLE FACTURE (
  CODEFAC SERIAL PRIMARY KEY,
  DATEFAC DATE DEFAULT CURRENT_DATE
);

CREATE TABLE SESSION (
  REFCOURS INTEGER,
  NUMEMP INTEGER,
  CODEFAC INTEGER,
  DATEDEB DATE NOT NULL,
  NBPLACEMAX INTEGER DEFAULT 10,
  CONSTRAINT PK_SESSION PRIMARY KEY (REFCOURS, NUMEMP),
  CONSTRAINT FK_SESSION_REFCOURS FOREIGN KEY (REFCOURS) REFERENCES COURS(REFCOURS),
  CONSTRAINT FK_SESSION_NUMEMP FOREIGN KEY (NUMEMP) REFERENCES EMPLOYER(NUMEMP),
  CONSTRAINT FK_SESSION_CODEFAC FOREIGN KEY (CODEFAC) REFERENCES FACTURE(CODEFAC)
);
