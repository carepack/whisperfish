package main

import (
	"io/ioutil"

	"gopkg.in/yaml.v2"
)

type Settings struct {
	Incognito         bool   `yaml:"incognito"`
	EnableNotify      bool   `yaml:"enable_notify"`
	ShowNotifyMessage bool   `yaml:"show_notify_message"`
	EncryptDatabase   bool   `yaml:"encrypt_database"`
	SaveAttachments   bool   `yaml:"save_attachments"`
	CountryCode       string `yaml:"country_code"`
}

func (s *Settings) SetDefault() {
	s.Incognito = false
	s.EnableNotify = true
	s.ShowNotifyMessage = false
	s.EncryptDatabase = true
	s.SaveAttachments = true
	s.CountryCode = ""
}

func (s *Settings) Load(file string) error {
	b, err := ioutil.ReadFile(file)
	if err != nil {
		return err
	}

	err = yaml.Unmarshal(b, s)
	if err != nil {
		return err
	}

	return nil
}

func (s *Settings) Save(file string) error {
	b, err := yaml.Marshal(s)
	if err != nil {
		return err
	}
	return ioutil.WriteFile(file, b, 0600)
}
