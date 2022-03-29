<?php

namespace App\Tests;
/**
 * DatabaseClear
 * 
 * Ajout la sauvegarde et la réinitialisation de la base de données de test
 * en créant une copie.
 * A ajouté dans les classes ou methodes des tests suivant les besoins.
 * 
 */
trait DatabaseClear
{
    /**
     * Chemin de la base de données de test
     * 
     * @var string
     */
    private $databaseFile = "./data/database.sqlite";

    /**
     * Chemin de la sauvegarde base de données de test.
     * 
     * @var string
     */
    private $databaseFileSave = './data/_database.sqlite.save';

    /**
     * Sauvegarde la base de données test.
     */
    private function saveBddBefore(): void
    {
        if (file_exists($this->databaseFile)){
            \shell_exec('cp '. $this->databaseFile .' '. $this->databaseFileSave);
        }
    }

    /**
     * Restore la base de données test.
     */
    private function restoreBddAfter(): void
    {
        if (file_exists($this->databaseFileSave )){
            \shell_exec('cp '. $this->databaseFileSave .' '. $this->databaseFile);
        }
    }
}
