<?php
declare(strict_types=1);

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Symfony\Component\Routing\Attribute\Route;

#[
    AsController,
    Route('/api/array-calc', name: 'app:php_calc', methods: ['GET']),
]
class DefaultController extends AbstractController
{
    public function __invoke(): JsonResponse
    {
        $array = [1, 2, 3, 4, 5];

        array_walk(
            $array,
            static function (int &$value): void {
                $value *= 10;
            },
        );

        return $this->json([
            'count' => sprintf('Items in array: %s', count($array)),
            'array' => $array,
        ], Response::HTTP_OK);
    }
}
