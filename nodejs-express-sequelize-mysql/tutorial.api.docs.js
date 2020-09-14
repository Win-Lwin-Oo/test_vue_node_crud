// tutorial data schema
/**
 * @swagger
 *  components:
 *    schemas:
 *      Tutorial:
 *        type: object
 *        required:
 *          - title
 *          - description
 *          - published
 *        properties:
 *          title:
 *            type: string
 *          description:
 *            type: string
 *          published:
 *              type: boolean
 *        example:
 *           title: Js test
 *           description: This is js test
 *           published: true
 */

// create tutorial data
/**
 * @swagger
 * tags:
 *   name: Tutorial
 *   description: Create tutorial
 */

/**
 * @swagger
 * path:
 *  /:
 *    post:
 *      summary: Create a new tutorial
 *      tags: [Tutorial]
 *      requestBody:
 *        required: true
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/Tutorial'
 *      responses:
 *        "200":
 *          description: A tutorial schema
 *          content:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Tutorial'
 */

//get all tutorial data
/**
 * @swagger
 * tags:
 *   name: Tutorial list
 *   description: Get all tutorial or by title
 */

/**
 * @swagger
 * path:
 *  /:
 *    get:
 *      summary: Get all tutorial or by title
 *      tags: [Tutorial list]
 *      parameters:
 *          - in: query
 *            name: title
 *            schema:
 *              type: string
 *            description: title of the tutorial
 *      responses:
 *        "200":
 *          description: A tutorial schema
 *          content:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Tutorial'
 */

//get all published tutorial data
/**
 * @swagger
 * tags:
 *   name: Published Tutorial
 *   description: Get all published tutorial
 */

/**
 * @swagger
 * path:
 *  /published:
 *    get:
 *      summary: Get all published tutorial
 *      tags: [Published Tutorial]
 *      requestBody:
 *        required: false
 *      responses:
 *        "200":
 *          description: A tutorial schema
 *          content:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Tutorial'
 */

//get tutorial by id
/**
 * @swagger
 * tags:
 *   name: Specific Tutorial
 *   description: Get specific tutorial data by id
 */

/**
 * @swagger
 * path:
 *  /{id}:
 *    get:
 *      summary: Get tutorial data by id
 *      tags: [Specific Tutorial]
 *      parameters:
 *          - in: path
 *            name: id
 *            schema:
 *              type: integer
 *            required: true
 *            description: id of the tutorial
 *      responses:
 *        "200":
 *          description: A tutorial schema
 *          content:
 *            application/json:
 *              schema:
 *                $ref: '#/components/schemas/Tutorial'
 */

//update tutorial by id
/**
 * @swagger
 * tags:
 *   name: Update Tutorial
 *   description: Update tutorial
 */

/**
 * @swagger
 * path:
 *  /{id}:
 *    put:
 *      summary: Update tutorial data by id
 *      tags: [Update Tutorial]
 *      parameters:
 *          - in: path
 *            name: id
 *            schema:
 *              type: integer
 *            required: true
 *            description: id of the tutorial
 *      requestBody:
 *        required: true
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/Tutorial'
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
 *                      description: update success
 *                example:
 *                  message: update success
 */

 //delete tutorial by id
/**
 * @swagger
 * tags:
 *   name: Delete Tutorial
 *   description: Delete tutorial by id
 */

/**
 * @swagger
 * path:
 *  /{id}:
 *    delete:
 *      summary: Delete tutorial data by id
 *      tags: [Delete Tutorial]
 *      parameters:
 *          - in: path
 *            name: id
 *            schema:
 *              type: integer
 *            required: true
 *            description: id of the tutorial
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
 *                      description: update success
 *                example:
 *                  message: delete success
 */

 //delete all tutorial
/**
 * @swagger
 * tags:
 *   name: Delete All Tutorial
 *   description: Delete all tutorial data
 */

/**
 * @swagger
 * path:
 *  /:
 *    delete:
 *      summary: Delete all tutorial data
 *      tags: [Delete All Tutorial]
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
 *                      description: delete success
 *                example:
 *                  message: delete success
 */