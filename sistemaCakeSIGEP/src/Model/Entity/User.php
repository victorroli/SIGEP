<?php
namespace App\Model\Entity;

use Cake\ORM\Entity;

/**
 * User Entity
 *
 * @property int $id
 * @property string $username
 * @property string $password
 * @property string $nome
 * @property string $cpf
 * @property string $email
 * @property string $telefone
 * @property string $rua
 * @property int $numero
 * @property string $bairro
 * @property string $cidade
 * @property string $complemento
 * @property \Cake\I18n\FrozenTime $created
 * @property \Cake\I18n\FrozenTime $modified
 * @property int $institution_id
 * @property int $role_id
 *
 * @property \App\Model\Entity\Institution $institution
 * @property \App\Model\Entity\UsersHasGroup[] $users_has_groups
 * @property \App\Model\Entity\UsersHasProject[] $users_has_projects
 */
class User extends Entity
{

    /**
     * Fields that can be mass assigned using newEntity() or patchEntity().
     *
     * Note that when '*' is set to true, this allows all unspecified fields to
     * be mass assigned. For security purposes, it is advised to set '*' to false
     * (or remove it), and explicitly make individual fields accessible as needed.
     *
     * @var array
     */
    protected $_accessible = [
        '*' => true,
        'id' => false
    ];

    /**
     * Fields that are excluded from JSON versions of the entity.
     *
     * @var array
     */
    protected $_hidden = [
        'password'
    ];
}
