# Convention de commits

Ce dépôt contient des exercices (katas) et leurs solutions.
Les commits sont structurés pour rester lisibles dans le temps, faciliter la recherche, et permettre d’éventuelles PR.

## Format

```
<type>(<scope>) : <sujet>
```

---

### Types

* **chore**
  Ajout ou mise à jour du squelette de l’exercice (énoncé, fichiers de départ, setup).
* **feat**
  Implémentation de la solution de l’exercice.
* **fix**
  Correction apportée à la solution (bug, logique, cas limite).
* **test**
  Correction ou amélioration des tests (warnings compilateur, assertions, etc.).
* **refactor**
  Refactorisation sans changement de comportement.

---

### Scope

Le scope correspond au chemin de l’exercice :

```
langage/<nom-de-l-exercice>
```

Exemples :

* `gleam/secure-treasure-chest`
* `gleam/dna-encoding`
* `gleam/newsletter`

---

### Sujet

* À l’impératif
* Court et factuel
* Décrit **ce qui change**, pas pourquoi

Exemples :

```
chore(gleam/secure-treasure-chest) : ajout du squelette de l’exercice
feat(gleam/secure-treasure-chest) : implémentation de la solution
test(gleam/secure-treasure-chest) : suppression du warning Result inutilisé
fix(gleam/newsletter) : gestion best-effort des échecs d’envoi
```

---

### Corps du commit (optionnel mais recommandé)

Le corps peut préciser :

* une intention
* un choix d’implémentation
* un point d’apprentissage

Exemples :

```
Ignore explicitement la valeur de retour des assertions.
Le comportement des tests reste inchangé.
```

ou

```
Apprentissage : composition de Result, result.try, et agrégation via result.all
```

---

## Règles pratiques

* Un exercice peut tenir dans un seul commit `feat` si nécessaire.
* Les warnings compilateur et corrections de tests doivent être isolés (`test`).
* Les corrections après coup sur la solution doivent utiliser `fix`.
* La lisibilité et la traçabilité priment sur la concision.

---

## Philosophie

> Les commits servent avant tout à comprendre l'évolution du code,
> avoir un suivi de mon apprentissage et pouvoir isoler facilement
> les éventuelles corrections apportées aux tests.
