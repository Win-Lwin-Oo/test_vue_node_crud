/**
 * @swagger
 * tags:
 *   name: Welcome
 *   description: Welcome api
 */
/**
 * @swagger
 * /welcome:
 *  get:
 *      tags: [Welcome]
 *      description: Server simple api
 *      responses:
 *        "200":
 *          description: Ok
 *          content:
 *            application/json:
 *              schema:
 *                type: object,
 *                properties:
 *                  message:
 *                      type: string
 *                      description: Welcome
 *                example:
 *                  message: Welcome to node express sequelize
 */